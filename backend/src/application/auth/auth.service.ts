import { Injectable, BadRequestException, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { AuthRepository } from '../../infrastructure/auth/auth.repository';
import { InjectModel } from '@nestjs/mongoose';
import * as bcrypt from 'bcrypt';
import { User } from '../../domain/user.model';
import { Admin } from '../../domain/admin.model';
import { Model } from 'mongoose';

@Injectable()
export class AuthService {
    constructor(
        private readonly authRepository: AuthRepository,
        private readonly jwtService: JwtService,
        @InjectModel('User') private readonly userModel: Model<User>,@InjectModel('Admin') private readonly adminModel: Model<Admin>
    ) {}

    async createUser(name: string, email: string, password: string) {
        const result = await this.authRepository.createUser(name, email, password);
        return result;
    }
    
    async login(email: string, password: string) {
        const retrievedUser = await this.authRepository.getUserByEmail(email);
        if (!retrievedUser || !(await bcrypt.compare(password, retrievedUser.password))) {
            console.log("tueee")
            throw new UnauthorizedException("Invalid email or password");
        }
        const payload = {
            id: retrievedUser.id,
            email: retrievedUser.email,
            role: retrievedUser.role 
        };
    
        const jwt = this.jwtService.signAsync(payload); 
        return jwt;
    }
    
    async verifyToken(token: string): Promise<any> {
        try {
            return await this.jwtService.verifyAsync(token);
        } catch (error) {
            throw new UnauthorizedException('Invalid token');
        }
    }

    async getUser(cookie: string){
        try{
            const data = await this.jwtService.verifyAsync(cookie);
            if (!data){
                throw new UnauthorizedException();
            }
            const user = await this.authRepository.getUserByEmail(data.email);
            return {status: "success", id: user._id,name: user.username,email: user.email};
        } catch(err){
            throw new UnauthorizedException();
        }
    }


    async getAdmin(){
        const admin = await this.authRepository.getAdminByName("admin");
        if (!admin){
            const encoded = await bcrypt.hash("tablereserve",10);
            const admin = new this.adminModel({
                name: "admin",
                password: encoded
            });
            const user = new this.userModel({
                username: "Abebe",
                email:"adminAbebe@gmail.com",
                password: encoded,
                role: 'admin'
            });
            user.save();
            const createdAdmin = await admin.save();
        }
    }
    
    async verifyAdmin(name: string, password: string){
        const isVerified = await this.authRepository.verifyAdminCredentials(name, password);
        if (!isVerified) {
            throw new UnauthorizedException("Incorrect admin name or password");
        }
        return {
            statusCode: 200,
            message: "success"
        };
    }
    async changeUsername(name: string, id: string){
        const retrievedUser = await this.authRepository.findUserById(id);
        if (!retrievedUser) {
            throw new UnauthorizedException("User Not Found");
        }
        retrievedUser.username = name;
        retrievedUser.save();

        return {
            message: "Successfully Changed"
        };
    }
}
