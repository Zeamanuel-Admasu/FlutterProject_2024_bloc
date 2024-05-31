import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Reserve } from '../../domain/reserve.model';
import { Table } from 'src/domain/table.model';

import { Reservation } from './interface';




@Injectable()
export class ReserveRepository {
  constructor(@InjectModel('Reserve') private readonly reserveModel: Model<Reserve>,@InjectModel('Table') private readonly tableModel: Model<Table>) {}

  async createReservation(
    userId: string,
    numberOfPeople: number,
    dateOfReservation: string,
    time: string,
    branch:string,
    food:string
  ): Promise<Reserve> {
    const newReservation = new this.reserveModel({
      user_id: userId,
      Number_of_people: numberOfPeople,
      date_of_reservation: dateOfReservation,
      time: time,
      branch: branch,
      food: food
    });
    return await newReservation.save();
  }
  async getTodayReservations(today: string = new Date().toDateString()): Promise<Reservation[]> {
    let reservations: Array<Reservation> = [];
    const tables = await this.tableModel.find();
    for (var i: number = 0; i < tables.length; i++) {
        for (var j: number = 0; j < tables[i].reservations.length; j++) {
            if (new Date(tables[i].reservations[j].date_of_reservation).toDateString() === today) {
                let hours = new Date(tables[i].reservations[j].time).getHours();
                let minutes = new Date(tables[i].reservations[j].time).getMinutes();
                let period = 'AM';

                if (hours >= 12) {
                    period = 'PM';
                    if (hours > 12) {
                        hours -= 12;
                    }
                }
                reservations.push({
                    tableNumber: tables[i].tableNumber,
                    Type: tables[i].Type,
                    time: `${hours}:${minutes}${period}`,
                    date: new Date(tables[i].reservations[j].date_of_reservation).toDateString(),
                    Number_of_people: tables[i].reservations[j].Number_of_people
                })

            }

        }
    }
    return reservations;
}
async getReservationsByDate(inpDate: Date) {
    return await this.getTodayReservations(new Date(inpDate).toDateString());
}
async getUserReservations(id: string) {
    const resp = [];
    const tables = await this.tableModel.find();
    for (var i: number = 0; i < tables.length; i++) {
        for (var j: number = 0; j < tables[i].reservations.length; j++)
            if (tables[i].reservations[j].user_id === id) {
                let hours = new Date(tables[i].reservations[j].time).getHours();
                let minutes = new Date(tables[i].reservations[j].time).getMinutes();
                let period = 'AM';

                if (hours >= 12) {
                    period = 'PM';
                    if (hours > 12) {
                        hours -= 12;
                    }
                }
                resp.push({
                    tableNumber: tables[i].tableNumber,
                    Type: tables[i].Type,
                    time: `${hours}:${minutes}${period}`,
                    date: new Date(tables[i].reservations[j].date_of_reservation).toDateString(),
                    Number_of_people: tables[i].reservations[j].Number_of_people,
                    branch: tables[i].reservations[j].branch,
                    food: tables[i].reservations[j].food,


                })
            }
    }
    return resp;

}
async deleteReservation(tableNum: number){
    console.log(tableNum);
    const result = await this.tableModel.deleteOne({tableNumber: tableNum}).exec();
}
}
