clc
clear
x = csvread("30_ALLa.csv");
warning ("off");
pkg load signal
t=x (:,1); %tiempo
input_voltage=x (:,2); %voltaje de entrada
input_current=x (:,3); %corriente de entrada
output_voltage=x (:,4); %voltaje de salida
output_current=x (:,5); %corriente de salida

l=length(input_voltage);
#l1=2;
l1=round((l/6)*1);
l2=round((l/6)*6);
input_voltage=input_voltage(l1:l2);
input_current=input_current(l1:l2);
output_voltage=output_voltage(l1:l2);
output_current=output_current(l1:l2);
t=t(l1:l2);

power_input=input_voltage.*input_current;
power_output=output_voltage.*output_current;
li=length(power_input);
lo=length(power_output);
pi=sum(power_input)/length(power_input);
po=sum(power_output)/length(power_output);
eff= (po/pi)*100;
figure(1);
plot(t,input_voltage,"b",t,input_current,"r")

figure(2);
plot(t,power_input,"b",t,power_output,"r")
printf("El valor de la eficiencia es: %d \n",eff)
