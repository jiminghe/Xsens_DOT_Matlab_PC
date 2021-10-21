clear
scan = blelist("Timeout", 10); %scan ble devices, set the timeout 10secs.
DOT_Measure_ServiceUUID = "15172000-4947-11E9-8646-D663BD873D93";
DOT_Control_CharacteristicUUID = "15172001-4947-11E9-8646-D663BD873D93";
DOT_ShortPayload_CharacteristicUUID = "15172004-4947-11E9-8646-D663BD873D93";
Heading_Reset_Control_CharacteristicUUID = "15172006-4947-11E9-8646-D663BD873D93";
Select_Orientation_Euler = [01, 01, 04 ]; %Select the data output type, 04 means Euler Angles(Roll, Pitch, Yaw).
Select_Orientation_Quaternion = [01, 01, 05 ]; %Select the data output type, 05 means Quaternions(w, x, y, z).
Heading_Reset_Buffer = [01,00]; 


P01 = ble("D4CA6EF0C45D"); %Change P01 to your own DOT's tag name, Change the MAC Address to your own sensor's MAC Address.
EnableP01 = characteristic(P01, DOT_Measure_ServiceUUID, DOT_Control_CharacteristicUUID);
write( EnableP01, Select_Orientation_Euler); % You can change to your desired payload mode.
P01Dataoutput = characteristic(P01, DOT_Measure_ServiceUUID, DOT_ShortPayload_CharacteristicUUID); % You can change to your desired payload mode.
subscribe(P01Dataoutput);
Heading_Reset_P01 = characteristic(P01, DOT_Measure_ServiceUUID, Heading_Reset_Control_CharacteristicUUID); % heading rest, make sure your sensors are physically heading aligned, for example, in the charger.
write( Heading_Reset_P01, Heading_Reset_Buffer);

P03 = ble("D4CA6EF0BA88");
EnableP03 = characteristic(P03, DOT_Measure_ServiceUUID, DOT_Control_CharacteristicUUID);
write( EnableP03, Select_Orientation_Euler);
P03Dataoutput = characteristic(P03, DOT_Measure_ServiceUUID,DOT_ShortPayload_CharacteristicUUID);
subscribe(P03Dataoutput);
Heading_Reset_P03 = characteristic(P03, DOT_Measure_ServiceUUID, Heading_Reset_Control_CharacteristicUUID);
write( Heading_Reset_P03, Heading_Reset_Buffer);

P05 = ble("D4CA6EF0C79A");
EnableP05 = characteristic( P05, DOT_Measure_ServiceUUID, DOT_Control_CharacteristicUUID);
write( EnableP05, Select_Orientation_Euler);
P05Dataoutput = characteristic( P05, DOT_Measure_ServiceUUID,DOT_ShortPayload_CharacteristicUUID);
subscribe(P05Dataoutput);
Heading_Reset_P05 = characteristic(P05, DOT_Measure_ServiceUUID, Heading_Reset_Control_CharacteristicUUID);
write( Heading_Reset_P05, Heading_Reset_Buffer);

P04 = ble("D4CA6EF0C6AC");
EnableP04 = characteristic(  P04, DOT_Measure_ServiceUUID, DOT_Control_CharacteristicUUID);
write( EnableP04, Select_Orientation_Euler);
P04Dataoutput = characteristic(  P04, DOT_Measure_ServiceUUID,DOT_ShortPayload_CharacteristicUUID);
subscribe(P04Dataoutput);
Heading_Reset_P04 = characteristic(P04, DOT_Measure_ServiceUUID, Heading_Reset_Control_CharacteristicUUID);
write( Heading_Reset_P04, Heading_Reset_Buffer);

% B64 = ble("D4CA6EF17764");
% EnableB64 = characteristic(  B64, DOT_Measure_ServiceUUID, DOT_Control_CharacteristicUUID);
% write( EnableB64, Select_Orientation_Euler);
% B64Dataoutput = characteristic(  B64, DOT_Measure_ServiceUUID,DOT_ShortPayload_CharacteristicUUID);
% subscribe(B64Dataoutput);
% Heading_Reset_B64 = characteristic(B64, DOT_Measure_ServiceUUID, Heading_Reset_Control_CharacteristicUUID);
% write( Heading_Reset_B64, Heading_Reset_Buffer);
% 
% fprintf('start');



count = 400;
P01Roll = [];
P03Roll = [];
P05Roll = [];
P04Roll = [];
% B64Roll = [];

P01Pitch = [];
P03Pitch = [];
P05Pitch = [];
P04Pitch = [];
% B64Pitch = [];

P01Yaw = [];
P03Yaw = [];
P05Yaw = [];
P04Yaw = [];
% B64Yaw = [];

 
for i=1:count
    P01data = read(P01Dataoutput);
    P03data = read(P03Dataoutput);
    P05data = read(P05Dataoutput);
    P04data = read(P04Dataoutput);
%     B64data = read(B64Dataoutput);
        
    P01Roll(i)= rollConvert (P01data); %Roll
    P03Roll(i)= rollConvert (P03data);
    P05Roll(i)= rollConvert (P05data);
    P04Roll(i)= rollConvert (P04data);
%     B64Roll(i)= rollConvert (B64data);
    
    P01Pitch(i)= pitchConvert (P01data); %Pitch
    P03Pitch(i)= pitchConvert (P03data);
    P05Pitch(i)= pitchConvert (P05data);
    P04Pitch(i)= pitchConvert (P04data);
%     B64Pitch(i)= pitchConvert (B64data);
    
    P01Yaw(i)= yawConvert (P01data); %Yaw
    P03Yaw(i)= yawConvert (P03data);
    P05Yaw(i)= yawConvert (P05data);
    P04Yaw(i)= yawConvert (P04data);
%     B64Yaw(i)= yawConvert (B64data);
    
    tiledlayout(3,1) % Create a 3x1 plot
    
    ax1 = nexttile; % First plot
    plot(ax1,P01Roll,'red')
    title(ax1,'Plot 1')
    hold on  % Combine several data in one plot.
    plot(ax1,P03Roll,'green')
    plot(ax1,P05Roll,'blue')
    plot(ax1,P04Roll,'cyan')
%     plot(ax1,B64Roll,'magenta')
    title('Roll: Red:P01, Green:P03, Blue:P05, Cyan:P04, Magenta:B64')
    hold off
 
    ax2 = nexttile;
    plot(ax2,P01Pitch,'red')
    title(ax2,'Plot 2')
    hold on 
    plot(ax2,P03Pitch,'green')
    plot(ax2,P05Pitch,'blue')
    plot(ax2,P04Pitch,'cyan')
%     plot(ax2,B64Pitch,'magenta')
    title('Pitch: Red:P01, Green:P03, Blue:P05, Cyan:P04, Magenta:B64')
    hold off
    
    ax3 = nexttile;
    plot(ax3,P01Yaw,'red')
    title(ax3,'Plot 2')
    hold on 
    plot(ax3,P03Yaw,'green')
    plot(ax3,P05Yaw,'blue')
    plot(ax3,P04Yaw,'cyan')
%     plot(ax3,B64Yaw,'magenta')
    title('Yaw: Red:P01, Green:P03, Blue:P05, Cyan:P04, Magenta:B64')
    hold off
    
    
    

end
fprintf('done');



clear All
% disconnect



function  timeData = timeStampConvert(data)

    t = data (1:4);
    t = uint8 (t);
    timeData = typecast ( t, 'uint32' );
end

function  rollData = rollConvert(data)

    r = data (5:8);
    r = uint8 (r);
    rollData = typecast ( r, 'Single' );
end

function  pitchData = pitchConvert(data)
    p = data (9:12);
    p = uint8 (p);
    pitchData = typecast ( p, 'Single' );
end

function  yawData = yawConvert(data)
    y = data (13:16);
    y = uint8 (y);
    yawData = typecast ( y, 'Single' );
end














 
 