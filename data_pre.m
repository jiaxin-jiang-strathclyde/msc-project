L=99;%input length
load('House_plus.mat')% load original dataset
House_data=table2array(House_plus);
data_length=size(House_data);

input_ori = House_data(:,1);
delta = std(input_ori);
input_raw = input_ori/delta;% devide by Standard deviation
input_x = zeros(L,data_length(1)-L+1);

% all x pre-processed
for i=1:1:data_length(1)-L+1
    input_x(:,i) = input_raw(i:i+L-1);
end
for i=1:1:data_length(1)-L+1
    input_x(:,i) = input_x(:,i)-mean(input_x(:,i));%Subtract the average
end
input_x = single(input_x);

% all y pre-processed
House_data_o = House_data;
input_y_original = zeros(9,data_length(1)-L+1);
for i=1:1:data_length(1)-L+1
    input_y_original(:,i) = House_data_o((L-1)/2+i-1,2:end);
end

input_y_0max = zeros(10,data_length(1)-L+1);
for i=1:10
input_y_0max(i,:)=input_y_original(i,:)/max(input_y_original(i,:)); 
% devided by max
end
input_y_0max = single(input_y_0max);

input_app1=input_y_0max(1,:);
input_app2=input_y_0max(2,:);
input_app3=input_y_0max(3,:);
input_app4=input_y_0max(4,:);
input_app5=input_y_0max(5,:);
input_app8=input_y_0max(8,:);
input_app9=input_y_0max(9,:);

% here the appliance 1 fridge is choosed
thr = 0.25; %set the threshold
w5 = find(input_app1>thr);
of5 = get_off_state(input_app1,ww5);
input_x_fridge = input_x(:,of5);
input_y_fridge = input_app1(of5);
% save the data set
save input_y_fridge  input_y_fridge
save input_x_fridge input_x_fridge

function off_index = get_off_state(input,w)
k = 1:length(input);
k(w) = [];
ks = k(randperm(length(k)));
off_in = ks(1:round(length(w)*1));
off_index = [w,off_in];
end
