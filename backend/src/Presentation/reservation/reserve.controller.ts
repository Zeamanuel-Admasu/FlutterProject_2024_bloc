import {
    Controller,
    Post,
    Body,
    Get,
    Param,
    Patch,
    Delete,
    Req
  } from '@nestjs/common';
  
  import { ReserveService } from '../../application/reservation/reserve.service';
  
  @Controller('/reserve')

  export class ReserveController{
    constructor(private readonly reserveService: ReserveService) {}


    
    @Post("")
    async reserveTable(
        @Body('id') id: string,
        @Body('seats') tableSeats: string,
        @Body('type') tableType: string,
        @Body('date') date: string,
        @Body('time') time: string,
        @Body('branch') branch: string,
        @Body('food') food: string,

      ) {
        console.log("oy yeyeye");
        const data = new Date(date);
        const tableSeat = Number(tableSeats);

        const resp = await this.reserveService.reserveTable(
          id,
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
    @Get("/today")
    async getTodayReservations(){
      const todayReservations = await this.reserveService.getTodayReservations();
      return todayReservations;
    }
    @Get("/:inputtedDate")
    async getReservationsByDate(@Param('inputtedDate') inpDate:Date){
      const result = await this.reserveService.getReservationsByDate(inpDate);
      return result;

        
    }
    @Post("/userreservations")
    async getUserReservations(@Body("id") id:string){
      console.log("suuuuuuu");
      return this.reserveService.getUserReservations(id);
    }
    @Patch("")
    async updateReservation(@Body('id') id: string,

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
      const resp = await this.reserveService.updateReservation(
        tableNum,
        checktime,
        id,
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
    @Delete("/delete:tablesNumber&:time")
    async deleteReservation(@Param('tablesNumber') tableNum: number, @Param('time') time: string){
      console.log("deletetee")
      console.log(tableNum,time);
      const result = await this.reserveService.deleteReservation(tableNum,time)
      return result;
    }

    

  }