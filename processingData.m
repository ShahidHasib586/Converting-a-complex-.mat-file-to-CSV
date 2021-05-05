battery = 'B0005';
B = load(strcat(battery,".mat"));
cycle_number =0;
cycles_count = B.B0005.cycle;
cycles_count(1:10)
impedance_count = 0;
charge_c = 0;
discharge_c = 0;
fid = fopen(strcat(battery,'.csv'),'w');
fid_dis = fopen(strcat(battery,'-discharge.csv'),'w');
fprintf(fid,"Battery, Cycle_No, Date, Time, Temp, Reading_number, Sense_current_real, Sense_current_i, Battery_current_real, Battery_current_i, Current_ratio_real, Current_ratio_i, Battery_impedance_real, Battery_impedance_i, Rectified_Impedance_real, Rectified_Impedance_i, Re, Rct\n");
fprintf(fid_dis, "Battery, Cycle_No, Date, Time, Reading_number, Voltage_measured, Current_measured, Temperature_measured, Current_load, Voltage_load, Time_vector,Capacity\n");

for c=cycles_count
    type = c.type;
    class(type);
    cycle_number = cycle_number + 1;
    if strcmp(type,'impedance')
        time = c.time;
        year = time(1,1);
        month = time(1,2);
        day = time(1,3);
        hour = time(1,4);
        min = time(1,5);
        seconds = time(1,6);
        temp = c.ambient_temperature;
        data = c.data;
        s_c = data.Sense_current;
        b_c = data.Battery_current;
        c_r = data.Current_ratio;
        b_i = data.Battery_impedance;
        r_i = data.Rectified_Impedance;
        re = data.Re;
        rct = data.Rct;
        impedance_count = impedance_count + 1;
        pts = size(s_c);
        r_i_size = size(r_i);
        for i=1:pts(2)
            if i <= r_i_size(1)
                fmt = '%s, %d, %04d-%02d-%02d, %02d:%02d:%05.2f, %4.2f, %d, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f\n';
                fprintf(fid,fmt, battery, cycle_number, year, month, day, hour, min, seconds, temp, i, real(s_c(1,i)), imag(s_c(1,i)), ...
                    real(b_c(1,i)), imag(b_c(1,i)), real(c_r(1,i)), imag(c_r(1,i)), real(b_i(i,1)), imag(b_i(i,1)), ...
                    real(r_i(i,1)), imag(r_i(i,1)), re, rct);
%                 temp,s_c(1,i),b_c(1,i), c_r(1,i), b_i(i,1), r_i(i,1), re, rct);
            else
                fmt = '%s, %d, %04d-%02d-%02d, %02d:%02d:%05.2f, %4.2f, %d, %f, %f, %f, %f, %f, %f, %f, %f,,, %f, %f\n';
                fprintf(fid,fmt, battery, cycle_number, year, month, day, hour, min, seconds, temp, i, real(s_c(1,i)), imag(s_c(1,i)), ...
                    real(b_c(1,i)), imag(b_c(1,i)), real(c_r(1,i)), imag(c_r(1,i)), real(b_i(i,1)), imag(b_i(i,1)), ...
                    re, rct);
%                 temp,s_c(1,i),b_c(1,i), c_r(1,i), b_i(i,1), r_i(i,1), re, rct);
            end
        end

    end
    if strcmp(type,'charge')
        charge_c = charge_c + 1;

    end
end