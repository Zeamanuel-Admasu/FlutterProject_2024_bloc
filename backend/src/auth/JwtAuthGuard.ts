import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { AuthService } from '../application/auth/auth.service';

@Injectable()
export class JwtAuthGuard implements CanActivate {
    constructor(
        private jwtService: JwtService,
        private authService: AuthService 
    ) {}

    async canActivate(context: ExecutionContext): Promise<boolean> {
        const request = context.switchToHttp().getRequest();
        const token = request.headers.token;
        console.log(token);
    
    
        if (!token) {
            console.log("No token found");
            return false;
        }
    
        try {
            const decoded = await this.authService.verifyToken(token);
            request.user = decoded;
            console.log("Token verified successfully");
            return true;
        } catch (err) {
            console.log("Token verification failed:", err.message);
            return false;
        }
    }
}
