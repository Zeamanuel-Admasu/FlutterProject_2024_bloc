import {
    Controller,
    Post,
    Body,
    Get,
    Param,
    Patch,
    Delete,
    Req,
    UseGuards
  } from '@nestjs/common';
  
  import { ReserveService } from '../../application/reservation/reserve.service';
import { JwtAuthGuard } from 'src/auth/JwtAuthGuard';
import { AuthService } from 'src/application/auth/auth.service';
import { request } from 'express';
  
  @Controller('/reserve')

  export class ReserveController{
    constructor(private readonly reserveService: ReserveService,private readonly authService: AuthService ) {}


    
    @Post("")
    @UseGuards(JwtAuthGuard)
    async reserveTable(
      @Req() request,
        @Body('seats') tableSeats: string,
        @Body('type') tableType: string,
        @Body('date') date: string,
        @Body('time') time: string,
        @Body('branch') branch: string,
        @Body('food') food: string,

      ) {
        const token = request.headers.token as string;
        console.log(token);
        const _id = (await this.authService.getUser(token)).id.toString();
        console.log("oy yeyeye");
        const data = new Date(date);
        const tableSeat = Number(tableSeats);

        const resp = await this.reserveService.reserveTable(
          _id,
          tableSeat,
          tableType,
          data,
          time,
          branch,
          food
        );
        console.log(resp);
        return resp;
      }

    @Delete("/delete:tablesNumber&:time")
    @UseGuards(JwtAuthGuard)
    async deleteReservation(@Param('tablesNumber') tableNum: number, @Param('time') time: string){
      console.log("deletetee")
      console.log(tableNum,time);
      const result = await this.reserveService.deleteReservation(tableNum,time)
      return result;
    }

      




    @Get("/userreservations")
    @UseGuards(JwtAuthGuard)
    async getUserReservations(@Req() request){
      console.log("suuuuuuu");

      const token = request.headers.token as string;
      console.log(token);
      const _id = (await this.authService.getUser(token)).id.toString();
      console.log(_id);
      return this.reserveService.getUserReservations(_id);

    }

    

    @Get("/:inputtedDate")
    async getReservationsByDate(@Param('inputtedDate') inpDate:Date){
      const result = await this.reserveService.getReservationsByDate(inpDate);
      return result;

        
    }

    

    
    @Patch("")
    @UseGuards(JwtAuthGuard)

    async updateReservation(
      @Req() request,

    @Body('seats') tableSeats: number,
    @Body('type') tableType: string,
    @Body('date') date: Date,
    @Body('time') time: string,
    @Body('checktime') checktime: string,
    @Body('tableNumber') tableNum: number,
    @Body('branch') branch: string,
    @Body('food') food: string,


  ){
    console.log("korkaka");
    const token = request.headers.token as string;
    console.log(token);
    const _id = (await this.authService.getUser(token)).id.toString();
      const resp = await this.reserveService.updateReservation(
        tableNum,
        checktime,
        _id,
        tableSeats,
        tableType,
        date,
        time,
        branch,
        food,
      );
      console.log(resp);
      return resp;

    }

    
    
    

    

  }