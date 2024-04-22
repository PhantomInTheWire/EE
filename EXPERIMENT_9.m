% M-file: torque_speed_curve.m
% M-file create a plot of the torque-speed curve of the
% induction motor of Example 7-5.

% First, initialize the values needed in this program.
r1 = 0.641;               % Stator resistance
x1 = 1.106;               % Stator reactance
r2 = 0.332;               % Rotor resistance
x2 = 0.464;               % Rotor reactance
xm = 26.3;                % Magnetization branch reactance
v_phase = 460 / sqrt(3);  % Phase voltage
n_sync = 1800;            % Synchronous speed (r/min)
w_sync = 188.5;           % Synchronous speed (rad/s)

% Calculate the Thevenin voltage and impedance from Equations
% 7-41a and 7-43.
v_th = v_phase * (xm / sqrt(r1^2 + (x1 + xm)^2));
z_th = ((1j*xm) * (r1 + 1j*x1)) / (r1 + 1j*(x1 + xm));
r_th = real(z_th);
x_th = imag(z_th);

% Modified slip range (0.01 to 0.2)
s = (0.01:0.001:0.2);       % Slip
nm = (1 - s) * n_sync;      % Mechanical speed

% Calculate torque for original rotor resistance
for ii = 1:length(s)
   t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
               (w_sync * ((r_th + r2/s(ii))^2 + (x_th + x2)^2));
end

% Calculate torque for doubled rotor resistance
for ii = 1:length(s)
   t_ind2(ii) = (3 * v_th^2 * (2*r2) / s(ii)) / ...
               (w_sync * ((r_th + (2*r2)/s(ii))^2 + (x_th + x2)^2));
end

% Calculate torque for half rotor resistance
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
for ii = 1:length(s)
   t_ind3(ii) = (3 * v_th^2 * (0.5*r2) / s(ii)) / ...
               (w_sync * ((r_th + (0.5*r2)/s(ii))^2 + (x_th + x2)^2));
end

% Plot the torque-speed curve
figure(1);
plot(nm, t_ind1, 'Color', 'k', 'LineWidth', 2.0);
hold on;
plot(nm, t_ind2, 'Color', 'k', 'LineWidth', 2.0, 'LineStyle', '--');
plot(nm, t_ind3, 'Color', 'k', 'LineWidth', 2.0, 'LineStyle', '-.'); % Added plot
xlabel('\itn_m\rm\bf (r/min)', 'FontWeight', 'Bold');
ylabel('\tau_{ind}\rm\bf (N-m)', 'FontWeight', 'Bold');
title ('Induction Motor Torque-Speed Characteristic', 'FontWeight', 'Bold');
legend ('Original R_2', 'Doubled R_2(2)', 'Half R_2(0.5)'); % Updated legend
grid on;
hold off;