import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from '../../domain/user.model';
import { Admin } from '../../domain/admin.model';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthRepository {
    constructor(
        @InjectModel('User') private readonly userModel: Model<User>,
        @InjectModel('Admin') private readonly adminModel: Model<Admin>,
    ) {}

    async createUser(name: string, email: string, password: string) {
        const retrievedUser = await this.userModel.findOne({ email });
        if (retrievedUser) {
            throw new BadRequestException("Email already exists");
        }
        const hashedPassword = await bcrypt.hash(password, 10);
        const newUser = new this.userModel({
            username: name,
            email,
            password: hashedPassword,
            role: 'user'
        });
        await newUser.save();
        return {
            message: "user created",
            statusCode: 200
        };
    }

    async getUserByEmail(email: string): Promise<User | null> {
        return await this.userModel.findOne({ email }).exec();
    }
    async findUserById(id: string): Promise<User | null> {
        return await this.userModel.findById(id).exec();
    }

    async getAdminByName(name: string): Promise<Admin | null> {
        return await this.adminModel.findOne({ name }).exec();
    }

    async createAdmin(name: string, password: string) {
        const encodedPassword = await bcrypt.hash(password, 10);
        const newAdmin = new this.adminModel({
            name,
            password: encodedPassword,
        });
        await newAdmin.save();
        return newAdmin;
    }

    async verifyAdminCredentials(name: string, password: string): Promise<boolean> {
        const admin = await this.adminModel.findOne().where("name").equals("admin");
        if (!admin) return false;
        return await bcrypt.compare(password, admin.password);
    }
}
