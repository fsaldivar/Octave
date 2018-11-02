clc
clear
load a001;
warning ("off");
pkg load signal
l=length(t);
t1=t(l);
delta=t(2)-t(1);
f=60;
ciclos=t1*f;
ciclos
dpc=l/ciclos;



%ENTRADAS
IAT1=iFteHa;
IAT2=iHb;
IBT1=iXaXaa;
IBT2=0;
V_BT=vXaa;

%AJUSTES
a=31.75;
k_AT=0.3;
k_ATBT=0.3;
InomAT=3.28;
Ipk_AT=.01*InomAT;
Ipk_ATBT=0.1*InomAT*a;

%CALCULOS
IAT_Nom=((IAT1+IAT2)/2)*a;
IBT_Nom=(IBT1+IBT2);

m=1;
n=1;
for i=1:ciclos;
%for i=1:180;


IAT_Noma=IAT_Nom(m:dpc*i);
IAT_Noma=rms(IAT_Noma);

IBT_Noma=IBT_Nom(m:dpc*i);
IBT_Noma=rms(IBT_Noma);

VBT_Noma=V_BT(m:dpc*i);
printf(" \n")
VBT_Noma=rms(VBT_Noma)


printf("Ciclo  %d \n",  i)

I_R_AB=(IAT_Noma+IBT_Noma)/2;
I_D_AB=(IAT_Noma-IBT_Noma);
kIR_AB=k_ATBT*I_R_AB;
Ipk_ATBT;


tinrush=t(round(dpc*i)); #tiempo de inrush
IAT1_Noma=IAT1(m:dpc*i);
IAT1_Noma=rms(IAT1_Noma);
inrush=(6.0245*(tinrush)^-0.306)*IAT1_Noma*a;

IAT2_Noma=IAT2(m:dpc*i);
IAT2_Noma=rms(IAT2_Noma);
I_R_AT=(IAT1_Noma+IAT2_Noma)/2;
I_D_AT=(IAT1_Noma-IAT2_Noma);
kIR_AT=k_AT*I_R_AT;



  if((I_D_AB > kIR_AB) && (I_D_AB > Ipk_ATBT))

printf("Detecto anomalia, puede ser Inrush  %d \n", n)

    if (I_D_AB > inrush)
     printf("FALLA entre devanados ATBT  \n")
    else
          if (VBT_Noma<=120)
          printf("Falla Interna entre devanados de ATBT \n")
          else
          printf("Por debajo de Inrush \n")
          printf("Healty ATBT \n")
          endif

    endif
    n=n+1;
  else
  n=1;
  printf ("Healty ATBT \n")
  endif

  if((I_D_AT > kIR_AT) && (I_D_AT > Ipk_AT))
  printf("Falla Interna en AT \n")
%  printf ("------------------------ \n");
  else
  printf ("Healty en devanado de AT \n")
%  printf ("------------------------\n");
  endif


  if (VBT_Noma<=240*0.9)
  printf("Caida de Voltaje \n")
  else
  printf("Voltaje Ok \n")
  endif


m; %informativo
resp_f=dpc*i; %informativo
m=m+dpc; %informativo
endfor





%figure 1;
%plot(t,iFteHa*a,"r");
%figure 2;
%plot(t,IBT1);


%figure 3;
%plot(t(1:dpc),IAT1(1:dpc),"r");
%hold;
%plot(t(1:dpc),IBT1(1:dpc));
%hold;
