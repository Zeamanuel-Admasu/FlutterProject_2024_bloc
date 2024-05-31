import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Observable } from 'rxjs';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AdminAuthGuard implements CanActivate {
  constructor(private readonly jwtService: JwtService) {}

  canActivate(context: ExecutionContext): boolean | Promise<boolean> | Observable<boolean> {
    const request = context.switchToHttp().getRequest();
    const token = request.headers.authorization;
    console.log(token);// Assuming JWT token is stored in a cookie named 'jwt'

    if (!token) {
        console.log("No token")
      return false; // No token, access denied
    }

    try {
      const decoded = this.jwtService.verify(token);
    
      if (decoded && decoded.role === 'admin') {
        console.log('admin')
        return true; // User i
      } else {
        console.log('user')
        return false; // User is not admin, access denied
      }
    } catch (err) {
        console.log('shit')
      return false; // Token verification failed, access denied
    }
  }
}
