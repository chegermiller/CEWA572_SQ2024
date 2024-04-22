%% STEP 0: This MATLAB code uses a Forward Time and Centered Space approach to solve the partial differential equation for heat conduction.
clear all %#ok<CLALL>
%% STEP 1 : Define parameters and constants
%Provide dimensions of the rod (x0 and x1).
x0        = 0;                        
x1        = 1;
L         = x1-x0; %Rod length

%Provide the number of x-grid points
n         = 39;        %Number of nodes
dX        = L./(n+1);

%Provide the number of time steps
m         = 600;       %Number of time steps
T         = 12000;
dT        = T./m;

%Define diffusivity
kappa     = 10^-5;

%Define gain parameter s
s         = kappa*dT/(dX^2);  

%% STEP 2: Create the matrix A and vector B

for i=1:1:n
    if i==1
        A(i,i)=1-2*s;
        A(i,i+1)=s;
    elseif i==n
        A(i,i-1)=s;
        A(i,i)=1-2*s;
    else
        A(i,i)=1-2*s;
        A(i,i-1)=s;
        A(i,i+1)=s;
    end
end

B        = zeros(n,1);

%% STEP 3: Create Boundary Conditions

%Applying Dirichlet Boundary Conditions
B(1)     = s;

%Applying Neumann Boundary Conditions
A(n,n)   = 1-s;
B(n)     = 2*s*dX;

%% STEP 4: Create Mesh and Time
x        = x0+dX:dX:x1-dX;
t0       = 0;

%% STEP 5: Provide Initial Conditions
U_xt     = 2.*x + sin(2*pi*x) + 1.;
U_xt     = U_xt(:);

%% STEP 6: Create Storage Matrix
U        = zeros(m,n);
U(1,:)   = U_xt;
t        = zeros(m,1);
t(1)     = t0;


%% STEP 7: March in Time Now

for i = 1:1:m
    U_xt_n   = A*U_xt + B;    
    U(i+1,:) = U_xt_n;
    U_xt     = U_xt_n;
    t(i+1)   = t(i)+dT;     
end

figure
pcolor(x,t,U)
shading interp



