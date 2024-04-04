package com.travel.utility;

import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Value;

import com.travel.bean.ContactForm;
import com.travel.object.bookingrequest.BookingRequest;
import com.travel.object.searchRequest.FlightRequest;

public class Emails
{
    @Value("${tfn}")
    private String tfn;
    
    public String buildFlightEmail(BookingRequest bookingRequest, FlightRequest searchRequest) {
        StringBuffer buffer = new StringBuffer();
        buffer.append("<html>");
        buffer.append("<body>");
        buffer.append("<table width='100%' border='0' cellpadding='0' cellspacing='0' style='max-width:700px;min-width:700px;margin:auto;border:1px solid #dddddd;font-family:Arial, Helvetica, sans-serif;'>");
        buffer.append("<tr>");
        buffer.append("<td>");
        buffer.append("<a href='https://www.lowtickets.com' target='_blank'>");
        buffer.append("<img src='https://www.lowtickets.com/resources/images/logo.png' style='height:50px;margin-left:15px;'>");
        buffer.append("</a>");
        buffer.append("</td>");
        buffer.append("<td style='text-align:right; color:#FF4500;font-family:Arial, Helvetica, sans-serif;font-weight:500;padding:10px 20px 0 0;'>");
        buffer.append("Call Us:<a href='tel:1-800-984-7414' style=' color:#17252A;font-size:20px;text-decoration:none;'>1-800-984-7414</a>");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2' style='background-color:#FF4500;height:30px;'></td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2' style='padding:15px 0;'><img src='https://www.lowtickets.com/resources/images/confirm.png' style='margin:auto;display:block;' width='80px' height='80px'></td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2' style='text-align:center;font-size:22px;color:#17252A;font-weight:600;padding:5px;'>Your trip is now booked and in process.</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2' style='text-align:center;color:#666666;padding:5px;'>");
        buffer.append("Your E-Tickets will be sent shortly in a separate email once the process is completed.");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2' style='text-align:center;color:#666666;padding:5px;'>");
        buffer.append("For immediate help on your booking, please call us at <a style='color:#17252A;text-decoration:none;' href='tel:1-800-984-7414'>1-800-984-7414</a> between 8am to 9pm (EST).");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2' style='text-align:center;color:#666666;padding:5px;'>");
        buffer.append("Your booking reference number is");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2' style='text-align:center;padding:5px;font-size:30px;color:#17252A;font-weight:600;'>");
        buffer.append(new StringBuilder().append(bookingRequest.getBookingID()).toString());
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2' style='background-color:#FF4500;padding-left:15px;font-size:20px;color:#ffffff;font-weight:550;height:35px'>");
        buffer.append("Flight Summary");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2'>");
        buffer.append("<table width='100%' border='0' cellpadding='0' cellspacing='0' style='background-color:#eeeeee;font-family:Arial, Helvetica, sans-serif;padding:5px 20px;'>");
        SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss");
        //SimpleDateFormat dateformatTime = new SimpleDateFormat("hh:mm:a");
        SimpleDateFormat dateformatDate = new SimpleDateFormat("dd, MMM yyyy");
        DateFormat inputFormat = new SimpleDateFormat("HH:mm");
        DateFormat outputFormat = new SimpleDateFormat("hh:mm a");
        buffer.append("<tr>");
        buffer.append("<td width='100%' colspan='3' style='color:#17252A;font-size:17px;font-weight:600;padding:10px 0;'>");
        buffer.append("Departure Flights <span style='font-size:16px;font-weight:400;'></span>");
        buffer.append("</td>");
        buffer.append("</tr>");
        for (int j = 0; j < bookingRequest.getFlightResult().getOutBound().size(); j++) {
            String depFroTimeStr = "";
            String depFroDateStr = "";
            String depToTimeStr = "";
            String depToDateStr = "";
            try {
                Date depDate = dateformat.parse(bookingRequest.getFlightResult().getOutBound().get(j).getDepDate());
                depFroTimeStr = outputFormat.format(inputFormat.parse(bookingRequest.getFlightResult().getOutBound().get(j).getDepDate().split("T")[1]));
                depFroDateStr = dateformatDate.format(depDate);
                Date reachDate = dateformat.parse(bookingRequest.getFlightResult().getOutBound().get(j).getReachDate());
                depToTimeStr = outputFormat.format(inputFormat.parse(bookingRequest.getFlightResult().getOutBound().get(j).getReachDate().split("T")[1]));
                depToDateStr = dateformatDate.format(reachDate);
            }
            catch (ParseException e) {
                e.printStackTrace();
            }
            buffer.append("<tr>");
            buffer.append("<td style='display:flex;align-items:center;font-size:15px;padding:5px;color:#444444'><img src='https://www.lowtickets.com/resources/images/airline-logo/" + bookingRequest.getFlightResult().getOutBound().get(j).getAirline() + ".png' width='50px' height='30px'> " + bookingRequest.getFlightResult().getOutBound().get(j).getAirlineName() + "</td>");
            buffer.append("<td style='text-align:center;font-size:14px;font-weight:550;padding:5px;color:#444444'>Flight No: <span style='font-size:13px;font-weight:400;'>" + bookingRequest.getFlightResult().getOutBound().get(j).getFlightNo() + "</span></td>");
            String cabin = "";
            if (bookingRequest.getFlightResult().getOutBound().get(j).getCabinClass() == 1) {
                cabin = "Economy";
            }
            else if (bookingRequest.getFlightResult().getOutBound().get(j).getCabinClass() != 2) {
                if (bookingRequest.getFlightResult().getOutBound().get(j).getCabinClass() == 3) {
                    cabin = "Business";
                }
                else if (bookingRequest.getFlightResult().getOutBound().get(j).getCabinClass() == 4) {
                    cabin = "First";
                }
            }
            buffer.append("<td style='text-align:right;font-size:14px;font-weight:550;padding:5px;color:#444444'>Class : <span style='font-size:13px;font-weight:400;'>" + cabin + "</span></td>");
            buffer.append("</tr>");
            buffer.append("<tr>");
            buffer.append("<td style='padding:5px;color:#666666;'>" + depFroDateStr + "," + depFroTimeStr + "</td>");
            buffer.append("<td style='text-align:center;padding:5px;color:#666666;'><img src='https://www.lowtickets.com/resources/images/clocko.png' width='14px;' height='14px;'>" + Utility.timeConversion(bookingRequest.getFlightResult().getOutBound().get(j).getEft()) + "</td>");
            buffer.append("<td style='text-align:right;padding:5px;color:#666666;'>" + depToDateStr + "," + depToTimeStr + "</td>");
            buffer.append("</tr>");
            buffer.append("<tr>");
            buffer.append("<td style='padding:5px;color:#17252A;font-weight:550;'>" + bookingRequest.getFlightResult().getOutBound().get(j).getFromAirport() + "<span style='font-weight:400;color:#444444;'>(" + bookingRequest.getFlightResult().getOutBound().get(j).getFroCityName() + ")</span></td>");
            buffer.append("<td style='text-align:center;padding:5px;'><img src='https://www.lowtickets.com/resources/images/rightarrow.png' width='30px;' height='30px;'></td>");
            buffer.append("<td style='padding:5px;color:#17252A;font-weight:550;text-align:right;'>" + bookingRequest.getFlightResult().getOutBound().get(j).getToAirport() + "<span style='font-weight:400;color:#444444'>(" + bookingRequest.getFlightResult().getOutBound().get(j).getToCityName() + ")</span></td>");
            buffer.append("</tr>");
            buffer.append("<tr>");
            buffer.append("<td style='font-size:15px;padding:0 5px;color:#444444'>" + bookingRequest.getFlightResult().getOutBound().get(j).getFromAirportName() + "</td>");
            buffer.append("<td style='text-align:center;font-size:14px;font-weight:550;padding:0 5px;color:#444444'>Non-Stop</td>");
            buffer.append("<td style='text-align:right;font-size:15px;padding:0 5px;color:#444444'>" + bookingRequest.getFlightResult().getOutBound().get(j).getToAirportName() + "</td>");
            buffer.append("</tr>");
            buffer.append("<tr style='height:10px;'></tr>");
            if (bookingRequest.getFlightResult().getOutBound().get(j).getLayOverTime() > 0) {
                buffer.append("<tr style='height:30px;'>");
                buffer.append("<td><hr style='border:dashed #999999;border-width:0 0 1px 0'></td>");
                buffer.append("<td style='text-align:center;color:#666666;font-size:13px;font-weight:500;'><img src='/resources/images/clocko.png' width='13px;' height='13px;'> " + Utility.timeConversion(bookingRequest.getFlightResult().getOutBound().get(j).getLayOverTime()) + " layover in " + bookingRequest.getFlightResult().getOutBound().get(j).getToCityName() + " (" + bookingRequest.getFlightResult().getOutBound().get(j).getToAirport() + ")</td>");
                buffer.append("<td><hr style='border:dashed #999999;border-width:0 0 1px 0'></td>");
                buffer.append("</tr>");
            }
        }
        if (searchRequest.getTripType() != 1) {
            buffer.append("<tr>");
            buffer.append("<td width='100%' colspan='3' style='color:#17252A;font-size:17px;font-weight:600;padding:10px 0;'>");
            if (searchRequest.getTripType() == 2) {
                buffer.append("Return Flights <span style='font-size:16px;font-weight:400;'></span>");
            }
            else if (searchRequest.getTripType() == 3) {
                buffer.append("Departure Flights <span style='font-size:16px;font-weight:400;'></span>");
            }
            buffer.append("</td>");
            buffer.append("</tr>");
            for (int j = 0; j < bookingRequest.getFlightResult().getInBound().size(); j++) {
                String depFroTimeStr = "";
                String depFroDateStr = "";
                String depToTimeStr = "";
                String depToDateStr = "";
                try {
                    Date depDate = dateformat.parse(bookingRequest.getFlightResult().getInBound().get(j).getDepDate());
                    depFroTimeStr = outputFormat.format(inputFormat.parse(bookingRequest.getFlightResult().getInBound().get(j).getDepDate().split("T")[1]));
                    depFroDateStr = dateformatDate.format(depDate);
                    Date reachDate = dateformat.parse(bookingRequest.getFlightResult().getInBound().get(j).getReachDate());
                    depToTimeStr = outputFormat.format(inputFormat.parse(bookingRequest.getFlightResult().getInBound().get(j).getReachDate().split("T")[1]));
                    depToDateStr = dateformatDate.format(reachDate);
                }
                catch (ParseException e) {
                    e.printStackTrace();
                }
                buffer.append("<tr>");
                buffer.append("<td style='display:flex;align-items:center;font-size:15px;padding:5px;color:#444444'><img src='https://www.lowtickets.com/resources/images/" + bookingRequest.getFlightResult().getInBound().get(j).getAirline() + ".png' width='50px' height='30px'> " + bookingRequest.getFlightResult().getInBound().get(j).getAirlineName() + "</td>");
                buffer.append("<td style='text-align:center;font-size:14px;font-weight:550;padding:5px;color:#444444'>Flight No: <span style='font-size:13px;font-weight:400;'>" + bookingRequest.getFlightResult().getInBound().get(j).getFlightNo() + "</span></td>");
                String cabin = "";
                if (bookingRequest.getFlightResult().getInBound().get(j).getCabinClass() == 1) {
                    cabin = "Economy";
                }
                else if (bookingRequest.getFlightResult().getInBound().get(j).getCabinClass() != 2) {
                    if (bookingRequest.getFlightResult().getInBound().get(j).getCabinClass() == 3) {
                        cabin = "Business";
                    }
                    else if (bookingRequest.getFlightResult().getInBound().get(j).getCabinClass() == 4) {
                        cabin = "First";
                    }
                }
                buffer.append("<td style='text-align:right;font-size:14px;font-weight:550;padding:5px;color:#444444'>Class : <span style='font-size:13px;font-weight:400;'>" + cabin + "</span></td>");
                buffer.append("</tr>");
                buffer.append("<tr>");
                buffer.append("<td style='padding:5px;color:#666666;'>" + depFroDateStr + "," + depFroTimeStr + "</td>");
                buffer.append("<td style='text-align:center;padding:5px;color:#666666;'><img src='https://www.lowtickets.com/resources/images/clocko.png' width='14px;' height='14px;'>" + Utility.timeConversion(bookingRequest.getFlightResult().getInBound().get(j).getEft()) + "</td>");
                buffer.append("<td style='text-align:right;padding:5px;color:#666666;'>" + depToDateStr + "," + depToTimeStr + "</td>");
                buffer.append("</tr>");
                buffer.append("<tr>");
                buffer.append("<td style='padding:5px;color:#17252A;font-weight:550;'>" + bookingRequest.getFlightResult().getInBound().get(j).getFromAirport() + "<span style='font-weight:400;color:#444444;'>(" + bookingRequest.getFlightResult().getInBound().get(j).getFroCityName() + ")</span></td>");
                buffer.append("<td style='text-align:center;padding:5px;'><img src='https://www.lowtickets.com/resources/images/rightarrow.png' width='30px;' height='30px;'></td>");
                buffer.append("<td style='padding:5px;color:#17252A;font-weight:550;text-align:right;'>" + bookingRequest.getFlightResult().getInBound().get(j).getToAirport() + "<span style='font-weight:400;color:#444444'>(" + bookingRequest.getFlightResult().getInBound().get(j).getToCityName() + ")</span></td>");
                buffer.append("</tr>");
                buffer.append("<tr>");
                buffer.append("<td style='font-size:15px;padding:0 5px;color:#444444'>" + bookingRequest.getFlightResult().getInBound().get(j).getFromAirportName() + "</td>");
                buffer.append("<td style='text-align:center;font-size:14px;font-weight:550;padding:0 5px;color:#444444'>Non-Stop</td>");
                buffer.append("<td style='text-align:right;font-size:15px;padding:0 5px;color:#444444'>" + bookingRequest.getFlightResult().getInBound().get(j).getToAirportName() + "</td>");
                buffer.append("</tr>");
                buffer.append("<tr style='height:10px;'></tr>");
                if (bookingRequest.getFlightResult().getInBound().get(j).getLayOverTime() > 0) {
                    buffer.append("<tr style='height:30px;'>");
                    buffer.append("<td><hr style='border:dashed #999999;border-width:0 0 1px 0'></td>");
                    buffer.append("<td style='text-align:center;color:#666666;font-size:13px;font-weight:500;'><img src='/resources/images/clocko.png' width='13px;' height='13px;'> " + Utility.timeConversion(bookingRequest.getFlightResult().getInBound().get(j).getLayOverTime()) + " layover in " + bookingRequest.getFlightResult().getInBound().get(j).getToCityName() + " (" + bookingRequest.getFlightResult().getInBound().get(j).getToAirport() + ")</td>");
                    buffer.append("<td><hr style='border:dashed #999999;border-width:0 0 1px 0'></td>");
                    buffer.append("</tr>");
                }
            }
        }
        if (searchRequest.getTripType() == 3) {
            for (int j = 0; j < bookingRequest.getFlightResult().getOtherBound().size(); j++) {
                buffer.append("<tr>");
                buffer.append("<td width='100%' colspan='3' style='color:#17252A;font-size:17px;font-weight:600;padding:10px 0;'>");
                buffer.append("Departure Flights <span style='font-size:16px;font-weight:400;'></span>");
                buffer.append("</td>");
                buffer.append("</tr>");
                for (int i = 0; i < bookingRequest.getFlightResult().getOtherBound().get(j).size(); ++i) {
                    String depFroTimeStr2 = "";
                    String depFroDateStr2 = "";
                    String depToTimeStr2 = "";
                    String depToDateStr2 = "";
                    try {
                        Date depDate2 = dateformat.parse(bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getDepDate());
                        depFroTimeStr2 = outputFormat.format(inputFormat.parse(bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getDepDate().split("T")[1]));
                        depFroDateStr2 = dateformatDate.format(depDate2);
                        Date reachDate2 = dateformat.parse(bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getReachDate());
                        depToTimeStr2 = outputFormat.format(inputFormat.parse(bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getReachDate().split("T")[1]));
                        depToDateStr2 = dateformatDate.format(reachDate2);
                    }
                    catch (ParseException e2) {
                        e2.printStackTrace();
                    }
                    buffer.append("<tr>");
                    buffer.append("<td style='display:flex;align-items:center;font-size:15px;padding:5px;color:#444444'><img src='https://www.lowtickets.com/resources/images/airline-logo/" + bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getAirline() + ".png' width='50px' height='30px'> " + bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getAirlineName() + "</td>");
                    buffer.append("<td style='text-align:center;font-size:14px;font-weight:550;padding:5px;color:#444444'>Flight No: <span style='font-size:13px;font-weight:400;'>" + bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getFlightNo() + "</span></td>");
                    String cabin2 = "";
                    if (bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getCabinClass() == 1) {
                        cabin2 = "Economy";
                    }
                    else if (bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getCabinClass() != 2) {
                        if (bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getCabinClass() == 3) {
                            cabin2 = "Business";
                        }
                        else if (bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getCabinClass() == 4) {
                            cabin2 = "First";
                        }
                    }
                    buffer.append("<td style='text-align:right;font-size:14px;font-weight:550;padding:5px;color:#444444'>Class : <span style='font-size:13px;font-weight:400;'>" + cabin2 + "</span></td>");
                    buffer.append("</tr>");
                    buffer.append("<tr>");
                    buffer.append("<td style='padding:5px;color:#666666;'>" + depFroDateStr2 + "," + depFroTimeStr2 + "</td>");
                    buffer.append("<td style='text-align:center;padding:5px;color:#666666;'><img src='https://www.lowtickets.com/resources/images/clocko.png' width='14px;' height='14px;'>" + Utility.timeConversion(bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getEft()) + "</td>");
                    buffer.append("<td style='text-align:right;padding:5px;color:#666666;'>" + depToDateStr2 + "," + depToTimeStr2 + "</td>");
                    buffer.append("</tr>");
                    buffer.append("<tr>");
                    buffer.append("<td style='padding:5px;color:#17252A;font-weight:550;'>" + bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getFromAirport() + "<span style='font-weight:400;color:#444444;'>(" + bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getFroCityName() + ")</span></td>");
                    buffer.append("<td style='text-align:center;padding:5px;'><img src='https://www.lowtickets.com/resources/images/rightarrow.png' width='30px;' height='30px;'></td>");
                    buffer.append("<td style='padding:5px;color:#17252A;font-weight:550;text-align:right;'>" + bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getToAirport() + "<span style='font-weight:400;color:#444444'>(" + bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getToCityName() + ")</span></td>");
                    buffer.append("</tr>");
                    buffer.append("<tr>");
                    buffer.append("<td style='font-size:15px;padding:0 5px;color:#444444'>" + bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getFromAirportName() + "</td>");
                    buffer.append("<td style='text-align:center;font-size:14px;font-weight:550;padding:0 5px;color:#444444'>Non-Stop</td>");
                    buffer.append("<td style='text-align:right;font-size:15px;padding:0 5px;color:#444444'>" + bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getToAirportName() + "</td>");
                    buffer.append("</tr>");
                    buffer.append("<tr style='height:10px;'></tr>");
                    if (bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getLayOverTime() > 0) {
                        buffer.append("<tr style='height:30px;'>");
                        buffer.append("<td><hr style='border:dashed #999999;border-width:0 0 1px 0'></td>");
                        buffer.append("<td style='text-align:center;color:#666666;font-size:13px;font-weight:500;'><img src='/resources/images/clocko.png' width='13px;' height='13px;'> " + Utility.timeConversion(bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getLayOverTime()) + " layover in " + bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getToCityName() + " (" + bookingRequest.getFlightResult().getOtherBound().get(j).get(i).getToAirport() + ")</td>");
                        buffer.append("<td><hr style='border:dashed #999999;border-width:0 0 1px 0'></td>");
                        buffer.append("</tr>");
                    }
                }
            }
        }
        buffer.append("</table>");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2' style='background-color:#FF4500;padding-left:15px;font-size:20px;color:#ffffff;font-weight:550;height:35px'>");
        buffer.append("Traveler(s) Details");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2'>");
        buffer.append("<table width='100%' border='0' cellpadding='0' cellspacing='0' style='font-family:Arial, Helvetica, sans-serif;padding:5px 0px;'>");
        buffer.append("<tr style='background-color:#dddddd;text-align:center;font-weight:550;'>");
        buffer.append("<td style='padding:5px;'>S.No.</td>");
        buffer.append("<td style='padding:5px;'>Name</td>");
        buffer.append("<td style='padding:5px;'>Gender</td>");
        buffer.append("<td style='padding:5px;'>DOB</td>");
        buffer.append("</tr>");
        for (int k = 0; k < bookingRequest.getPassengerDetails().size(); k++) {
            buffer.append("<tr style='background-color:#ffffff;text-align:center;font-weight:400;'>");
            buffer.append("<td style='padding:5px;'>" + (k + 1) + "</td>");
            buffer.append("<td style='padding:5px;'>" + bookingRequest.getPassengerDetails().get(k).getFirstName() + " " + bookingRequest.getPassengerDetails().get(k).getLastName() + "</td>");
            if (bookingRequest.getPassengerDetails().get(k).getGender() == 1) {
                buffer.append("<td style='padding:5px;'>Male</td>");
            }
            else {
                buffer.append("<td style='padding:5px;'>Female</td>");
            }
            buffer.append("<td style='padding:5px;'>" + bookingRequest.getPassengerDetails().get(k).getDobDay() + "-" + bookingRequest.getPassengerDetails().get(k).getDateOfMonth() + "-" + bookingRequest.getPassengerDetails().get(k).getDateOfYear() + "</td>");
            buffer.append("</tr>");
        }
        buffer.append("</table>");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2' style='background-color:#FF4500;padding-left:15px;font-size:20px;color:#ffffff;font-weight:550;height:35px'>");
        buffer.append("Contact Details");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2'>");
        buffer.append("<table width='100%' border='0' cellpadding='0' cellspacing='0' style='font-family:Arial, Helvetica, sans-serif;padding:5px 0px;'>");
        buffer.append("<tr style='background-color:#dddddd;text-align:center;font-weight:550;'>");
        buffer.append("<td style='padding:5px;'>Billing Phone</td>");
        /*buffer.append("<td style='padding:5px;'>Alternate Phone</td>");*/
        buffer.append("<td style='padding:5px;'>Email</td>");
        buffer.append("</tr>");
        buffer.append("<tr style='background-color:#ffffff;text-align:center;font-weight:400;'>");
        buffer.append("<td style='padding:5px;'>" + bookingRequest.getPhoneNo() + "</td>");
        /*buffer.append("<td style='padding:5px;'>" + bookingRequest.getMobileNo() + "</td>");*/
        buffer.append("<td style='padding:5px;'>" + bookingRequest.getEmailID() + "</td>");
        buffer.append("</tr>");
        buffer.append("</table>");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2' style='background-color:#FF4500;padding-left:15px;font-size:20px;color:#ffffff;font-weight:550;height:35px'>");
        buffer.append("Price Details");
        buffer.append("</td>");
        buffer.append("</tr>");
        double adultTotal = bookingRequest.getFlightResult().getFare().getAdultFare() + bookingRequest.getFlightResult().getFare().getAdultMarkup() + bookingRequest.getFlightResult().getFare().getAdultTax();
        double childTotal = bookingRequest.getFlightResult().getFare().getChildFare() + bookingRequest.getFlightResult().getFare().getChildMarkup() + bookingRequest.getFlightResult().getFare().getChildTax();
        double infantTotal = bookingRequest.getFlightResult().getFare().getInfantFare() + bookingRequest.getFlightResult().getFare().getInfantMarkup() + bookingRequest.getFlightResult().getFare().getInfantTax();
        double infantWsTotal = bookingRequest.getFlightResult().getFare().getInfantWsFare() + bookingRequest.getFlightResult().getFare().getInfantWsMarkup() + bookingRequest.getFlightResult().getFare().getInfantWsTax();
        buffer.append("<tr>");
        buffer.append("<td colspan='2'>");
        buffer.append("<table width='100%' border='0' cellpadding='0' cellspacing='0' style='font-family:Arial, Helvetica, sans-serif;padding:5px 10px;'>");
        buffer.append("<tr style='color:#17252A;font-weight:550'>");
        buffer.append("<td style='padding:5px;'><span>" + searchRequest.getAdults() + "</span> Traveler(s): <span>Adult</span></td>");
        buffer.append("<td style='padding:5px;text-align:right;'>"+"$"+"" + this.getDecimal2(adultTotal * searchRequest.getAdults() ) + "</td>");
        buffer.append("</tr>");
        buffer.append("<tr style='color:#17252A;font-weight:400;font-size:14px;'>");
        buffer.append("<td style='padding:5px;'>Flight Charges per adult</td>");
        buffer.append("<td style='padding:5px;text-align:right;'>"+"$"+"" + this.getDecimal2((bookingRequest.getFlightResult().getFare().getAdultFare() + bookingRequest.getFlightResult().getFare().getAdultMarkup() + bookingRequest.getFlightResult().getFare().getAdultTax())) + "</td>");
        buffer.append("</tr>");
        if (searchRequest.getChild() > 0) {
            buffer.append("<tr>");
            buffer.append("<td colspan='2'><hr></td>");
            buffer.append("</tr>");
            buffer.append("<tr style='color:#17252A;font-weight:550'>");
            buffer.append("<td style='padding:5px;'><span>" + searchRequest.getChild() + "</span> Traveler(s): <span>Child</span></td>");
            buffer.append("<td style='padding:5px;text-align:right;'>"+"$"+"" + this.getDecimal2(searchRequest.getChild() * childTotal ) + "</td>");
            buffer.append("</tr>");
            buffer.append("<tr style='color:#17252A;font-weight:400;font-size:14px;'>");
            buffer.append("<td style='padding:5px;'>Flight Charges per Child</td>");
            buffer.append("<td style='padding:5px;text-align:right;'>"+"$"+"" + this.getDecimal2((bookingRequest.getFlightResult().getFare().getChildFare() + bookingRequest.getFlightResult().getFare().getChildMarkup() + bookingRequest.getFlightResult().getFare().getChildTax())) + "</td>");
            buffer.append("</tr>");
        }
        if (searchRequest.getInfants() > 0) {
            buffer.append("<tr>");
            buffer.append("<td colspan='2'><hr></td>");
            buffer.append("</tr>");
            buffer.append("<tr style='color:#17252A;font-weight:550'>");
            buffer.append("<td style='padding:5px;'><span>" + searchRequest.getInfants() + "</span> Traveler(s): <span>Infant</span></td>");
            buffer.append("<td style='padding:5px;text-align:right;'>"+"$"+"" + this.getDecimal2(searchRequest.getInfants() * infantTotal ) + "</td>");
            buffer.append("</tr>");
            buffer.append("<tr style='color:#17252A;font-weight:400;font-size:14px;'>");
            buffer.append("<td style='padding:5px;'>Flight Charges per Infant</td>");
            buffer.append("<td style='padding:5px;text-align:right;'>"+"$"+"" + this.getDecimal2((bookingRequest.getFlightResult().getFare().getInfantFare() + bookingRequest.getFlightResult().getFare().getInfantMarkup() + bookingRequest.getFlightResult().getFare().getInfantTax())) + "</td>");
            buffer.append("</tr>");
        }
        if (searchRequest.getInfantsWs() > 0) {
            buffer.append("<tr>");
            buffer.append("<td colspan='2'><hr></td>");
            buffer.append("</tr>");
            buffer.append("<tr style='color:#17252A;font-weight:550'>");
            buffer.append("<td style='padding:5px;'><span>" + searchRequest.getInfantsWs() + "</span> Traveler(s): <span>Infant(WS)</span></td>");
            buffer.append("<td style='padding:5px;text-align:right;'>"+"$"+"" + this.getDecimal2(searchRequest.getInfantsWs() * infantWsTotal ) + "</td>");
            buffer.append("</tr>");
            buffer.append("<tr style='color:#17252A;font-weight:400;font-size:14px;'>");
            buffer.append("<td style='padding:5px;'>Flight Charges per Infant(WS)</td>");
            buffer.append("<td style='padding:5px;text-align:right;'>"+"$"+"" + this.getDecimal2((bookingRequest.getFlightResult().getFare().getInfantWsFare() + bookingRequest.getFlightResult().getFare().getInfantWsMarkup() + bookingRequest.getFlightResult().getFare().getInfantWsTax())) + "</td>");
            buffer.append("</tr>");
        }
		double pdpPrice=0.00;
		double taPrice=0.00;
		double webPrice=0.00;
		
		
		if(bookingRequest.getPriceDropTaken().equalsIgnoreCase("Yes")){
			pdpPrice = bookingRequest.getPriceDropAmount();
			buffer.append("<tr style='color:#17252A;font-weight:550'>");
			buffer.append("<td style='padding:5px;'> Price Drop Protection </td>");
			buffer.append("<td style='padding:5px;text-align:right;'>"+"$"+""+getDecimal2(bookingRequest.getPriceDropAmount())+"</td>");
			buffer.append("</tr>");
		}
		if(bookingRequest.getTravelAssistTaken().equalsIgnoreCase("Yes")){
			taPrice = bookingRequest.getTravelAssistAmount();
			buffer.append("<tr style='color:#17252A;font-weight:550'>");
			buffer.append("<td style='padding:5px;'> Travel Assist </td>");
			buffer.append("<td style='padding:5px;text-align:right;'>"+"$"+""+getDecimal2(bookingRequest.getTravelAssistAmount())+"</td>");
			buffer.append("</tr>");
		}
			if(bookingRequest.getWebcheckin().equalsIgnoreCase("Yes")){
			webPrice = bookingRequest.getWebcheckincost();
			buffer.append("<tr style='color:#17252A;font-weight:550'>");
			buffer.append("<td style='padding:5px;'> Web Checkin </td>");
			buffer.append("<td style='padding:5px;text-align:right;'>"+"$"+""+getDecimal2(bookingRequest.getWebcheckincost())+"</td>");
			buffer.append("</tr>");
		}
        buffer.append("<tr style='color:#17252A;font-weight:550;background-color:#eeeeee;'>");
        buffer.append("<td style='padding:5px;'>Total</td>");
		buffer.append("<td style='padding:5px;text-align:right;'>$"+getDecimal2(bookingRequest.getFlightResult().getFare().getGrandTotal()+pdpPrice+taPrice+webPrice)+"</td>");
        buffer.append("</tr>");
        buffer.append("<tr style='text-align:center;font-size:13px;color:#333;'>");
        buffer.append("<td colspan='2' style='padding:5px;'>NOTE: All Fares displayed are quoted in USD and inclusive of base fare, taxes and all fees. Additional baggage fees may apply as per the airline policies.</td>");
        buffer.append("</tr>");
        buffer.append("</table>");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2'><hr></td>");
        buffer.append("</tr>");
        buffer.append("<tr style='text-align:center;font-weight:550;'>");
        buffer.append("<td style='padding-top:20px;'>");
        buffer.append("<a href='https://www.lowtickets.com/privacy-policy' style='color:#FF4500;text-decoration:none;'>Privacy Policy</a>");
        buffer.append("</td>");
        buffer.append("<td style='padding-top:20px;'>");
        buffer.append("<a href='https://www.lowtickets.com/contactus' style='color:#FF4500;text-decoration:none;'>Support</a>");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr style='text-align:center;font-size:14px;color:#666666'>");
        buffer.append("<td style='padding:20px 15px 0 15px;'>");
        buffer.append("We are dedicated towards protecting your privacy. See our privacy policy for details.");
        buffer.append("</td>");
        buffer.append("<td style='padding:20px 15px 0 15px;'>");
        buffer.append("Contact our customer support team by phone & email 24x7 Toll Free 1-800-984-7414.");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr style='text-align:center;font-size:18px;color:#666666;font-weight:500;'>");
        buffer.append("<td colspan='2' style='padding-top:40px'>");
        buffer.append("Flight Booking Terms & Policies");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2'>");
        buffer.append("<table width='100%' border='0' cellpadding='0' cellspacing='0' style='font-family:Arial, Helvetica, sans-serif;padding:5px 20px;font-size:14px;color:#999999;font-weight:400;'>");
        buffer.append("<tr>");
        buffer.append("<td width='3%' style='padding:5px'><li></li></td>");
        buffer.append("<td width='97%' style='padding:5px'>Travelers must make sure they have all of the required travel documents and that they are current and valid for their destination.</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td width='3%' style='padding:5px'><li></li></td>");
        buffer.append("<td width='97%' style='padding:5px'>Fares are not guaranteed until tickets are issued. Fares are subject to availability of seats.</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td width='3%' style='padding:5px'><li></li></td>");
        buffer.append("<td width='97%' style='padding:5px'>");
        buffer.append("According to airline policies name changes are not allowed once the tickets are issued,");
        buffer.append("though some airlines allow minor corrections after payment of change fees.");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td width='3%' style='padding:5px'><li></li></td>");
        buffer.append("<td width='97%' style='padding:5px'>Flight schedules are subject to change by the Airlines due to changes in Airline Operations.</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td width='3%' style='padding:5px'><li></li></td>");
        buffer.append("<td width='97%' style='padding:5px'>Date and routing changes will be subject to airline rules and regulations.</td>");
        buffer.append("</tr>");
        buffer.append("</table>");
        buffer.append("</td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2'><hr></td>");
        buffer.append("</tr>");
        buffer.append("<tr>");
        buffer.append("<td colspan='2' style='text-align:center;padding:3%;color:#17252A;font-size:15px;'>&copy; Copyright 2021-2024 All right Reserved lowtickets.com</td>");
        buffer.append("</tr>");
        buffer.append("</table>");
        buffer.append("</body>");
        buffer.append("</html>");
        return buffer.toString();
    }
    public String buildContactEmail(ContactForm form){
		StringBuffer buffer=new StringBuffer(); 
		buffer.append("First Name : "+form.getFirstName()+"<br>");
		buffer.append("Last Name : "+form.getLastName()+"<br>");
		buffer.append("Email : "+form.getEmail()+"<br>");
		buffer.append("Phone : "+form.getPhone()+"<br>");
		buffer.append("Message : "+form.getMessage()+"<br>");
		return buffer.toString();
	}
    public String getDecimal2(double value) {
        NumberFormat nf = NumberFormat.getInstance();
        nf.setMaximumFractionDigits(2);
        return nf.format(value);
    }
}
