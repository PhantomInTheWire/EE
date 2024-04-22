% Parameters from Example 5-3
S_rated = 100e6;   % Rated apparent power (VA)
V_rated = 480;    % Rated line voltage (V)
Xs = 1.0;          % Synchronous reactance (pu)
pf = [0.2 0.4 0.6 0.8]; % Power factors (lagging)
pf_leading = -pf;   % Power factors (leading)

% Calculate rated current
I_rated = S_rated / (sqrt(3) * V_rated);

% Current range from no-load to full-load
I_range = linspace(0, I_rated, 100);

% Preallocate voltage matrices for efficiency
V_lag = zeros(length(pf), length(I_range));
V_lead = zeros(length(pf), length(I_range));

% Loop through power factors and current values
for i = 1:length(pf)
    for j = 1:length(I_range)
        I = I_range(j);
        theta = acos(pf(i));        % Angle for lagging pf
        theta_lead = -theta;       % Angle for leading pf
        
        % Calculate voltage using phasor equations
        E = V_rated + 1j*Xs*I*(cos(theta) + 1j*sin(theta));
        V_lag(i,j) = abs(E);
        E_lead = V_rated + 1j*Xs*I*(cos(theta_lead) + 1j*sin(theta_lead));
        V_lead(i,j) = abs(E_lead); 
    end
end

% Plot the results
figure;
hold on;
for i = 1:length(pf)
    plot(I_range, V_lag(i,:), 'DisplayName', ['Lagging PF = ' num2str(pf(i))]);
    plot(I_range, V_lead(i,:), '--', 'DisplayName', ['Leading PF = ' num2str(-pf_leading(i))]);
end
xlabel('Line Current (A)');
ylabel('Terminal Voltage (V)');
title('Synchronous Generator Terminal Characteristics');
legend('Location', 'best');
grid on;
hold off;