import { Injectable, NotFoundException } from '@nestjs/common';
import { ReserveRepository } from '../../infrastructure/reservation/reservation.repository';
import { TableRepository } from '../../infrastructure/table/table.repository';
import { Table } from '../../domain/table.model';
const moment = require("moment");

@Injectable()
export class ReserveService {
  constructor(
    private readonly reserveRepository: ReserveRepository,
    private readonly tableRepository: TableRepository
  ) {}

  async reserveTable(
    id: string,
    tableSeats: number,
    tableType: string,
    date: Date,
    time: string
  ) {
    const satisfyingTables = await this.tableRepository.findSatisfyingTables(tableType, tableSeats);
    const isoDate: string = moment(date).toISOString();
    const isoTime: string = moment(time, "HH:mm").toISOString();
    const ans = await this.checkAvailability(satisfyingTables, isoDate, isoTime);
    
    if (ans !== "") {
      const newReserve = await this.reserveRepository.createReservation(id, tableSeats, isoDate, isoTime);
      const reservedTable = await this.tableRepository.findById(ans);
      reservedTable.reservations.push(newReserve);
      await reservedTable.save();
      return { status: "success", message: "Table is Reserved" };
    } else {
      return { status: "error", message: "No available Table" };
    }
  }

  async checkAvailability(
    satisfyingTables: Table[],
    date: string,
    time: string
  ): Promise<string> {
    for (let i = 0; i < satisfyingTables.length; i++) {
      const table = satisfyingTables[i];
      let sameDay = false;

      if (table.reservations.length === 0) {
        return table.id;
      }

      for (var j = 0; j < table.reservations.length; j++) {
        let reservation = table.reservations[j];
        if (reservation.date_of_reservation === date) {
            let workingTime = new Date(reservation.time).getTime();
            workingTime /= 60_000;
            let otherTime = new Date(time).getTime();
            otherTime /= 60_000;
            sameDay = true;
            if (!(workingTime - 60 < otherTime && otherTime < workingTime + 60)) {
                return table.id;
            }
        }
    }

      if (!sameDay) {
        return table.id;
      }
    }

    return "";
  }

  async getTodayReservations(today: string = new Date().toDateString()): Promise<object[]> {
    const reservations = await this.reserveRepository.getTodayReservations(today);
    return reservations.map(reservation => ({
      tableNumber: reservation.tableNumber,
      Type: reservation.Type,
      time: moment(reservation.time).format("hh:mm A"),
      date: moment(reservation.date).format("YYYY-MM-DD"),
      Number_of_people: reservation.Number_of_people
    }));
  }

  async getReservationsByDate(inpDate: Date): Promise<object[]> {
    const reservations = await this.reserveRepository.getReservationsByDate(inpDate);
    return reservations.map(reservation => ({
      tableNumber: reservation.tableNumber,
      Type: reservation.Type,
      time: moment(reservation.time).format("hh:mm A"),
      date: moment(reservation.date).format("YYYY-MM-DD"),
      Number_of_people: reservation.Number_of_people
    }));
  }

  async updateReservation(
    tableNum: number,
    checktime: string,
    id: string,
    tableSeats: number,
    tableType: string,
    date: Date,
    time: string
  ) {
    const updatedTable = await this.tableRepository.findByTableNumber(tableNum);
    if (!updatedTable) {
      throw new NotFoundException('Table not found');
    }

    // Business logic for updating a reservation
    updatedTable.reservations.forEach(async (item) => {
      if (moment(item.time, "HH:mm").format("hh:mm A") === checktime) {
        await this.reserveTable(id, tableSeats, tableType, date, time);
      }
    });
  }

  async deleteReservation(tableNum: number, time: string) {
    console.log("hereeeeeeee")
    const table = await this.tableRepository.findByTableNumber(tableNum);
  
    if (!table) {
      throw new NotFoundException('Table not found');
    }
    let hr = new Date(moment(time, "HH:mm")).getHours();
        let min = new Date(moment(time, "HH:mm")).getMinutes();
        if (time.slice(-2) == "PM") {
            hr += 12;
        }
        table.reservations.forEach((item) => {
          console.log(item)
          console.log(hr,min,new Date(item.time).getHours());

        })
    

    table.reservations = table.reservations.filter(item => !(new Date(item.time).getHours() === hr && new Date(item.time).getMinutes() === min))
        await table.save();
  }

  async getUserReservations(id: string) {
    const userReservations = await this.reserveRepository.getUserReservations(id);
    return userReservations
  }
}
