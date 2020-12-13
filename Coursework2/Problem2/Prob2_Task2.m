%First the B1 flip
clear all
close all
set(0,'DefaultLegendAutoUpdate','off')

% for i=5
for i=1:5
    Gstep=(i-3).*2.3;

    mu=0.5;
    theta=0;
    phi=pi./2;
    
    N=256;
    GMax=4.6;
    Ts=5.12;
    noOfSteps = 16;
    L=20;
    spin_spacing=1;
    
    %The initial spin vector magnitudes
    
    %Uniform square distribution
    vecMus0=[0,-10,-5,-0,-10,-5,-0,-10,-5,-0,0,5,10,0,5,10,0,5,10;0,-10,-10,-10,-5,-5,-5,-0,-0,-0,0,0,0,5,5,5,10,10,10;0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5];
    
    vecMusReset=vecMus0;
    
    siz=size(vecMus0);
    no_of_spins = siz(2);
    
    %The initial spin vector origins
    vecMus0orig(1:2,:)=vecMus0(1:2,:);
    vecMus0orig(3,:)=zeros(1,no_of_spins);
    
    if i == 1
        h = figure;
        set(h, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    end
    
    h1=subplot(2,3,1);
    hold on;
    axis equal;
    view(100, 10);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    xlim([-12 12]);
    ylim([-12 12]);
    zlim([0 0.5]);
    grid on;

    stage=1;
    t=0;

    for i=0:noOfSteps-1

        t=(i+1).*0.02;

        theta=pi./32;


        %calculate the vectors of each spin
        for k = 1:no_of_spins

            %Moving initial vector to near origin
            vecMusInit(1,k)=vecMusReset(1,k)-vecMus0orig(1,k);
            vecMusInit(2,k)=vecMusReset(2,k)-vecMus0orig(2,k);
            vecMusInit(3,k)=vecMusReset(3,k)-vecMus0orig(3,k);;

            %x rotation
            [vecMusRot(1,k),vecMusRot(2,k),vecMusRot(3,k)]=x_rotation(vecMusInit(1,k),vecMusInit(2,k),vecMusInit(3,k),theta);

            %Resetting position to actual
            vecMusReset(1,k)=vecMusRot(1,k)+vecMus0orig(1,k);
            vecMusReset(2,k)=vecMusRot(2,k)+vecMus0orig(2,k); 
            vecMusReset(3,k)=vecMusRot(3,k)+vecMus0orig(3,k); 
        end

        %Plot the spin vectors
        hVecMu = plotSpin3D_2Dgrid(stage,no_of_spins,t,h1,vecMus0orig,vecMusReset);


        pause(0.001);

        ClearLinesFromAxes(h1);

    end
    plotSpin3D_2Dgrid(stage,no_of_spins,t,h1,vecMus0orig,vecMusReset);

    %%
    %Gy and Gx are on for Ts/2, this is the phase encoding gradient and
    %dephasing lobe of the readout

    %Redefine the axes to 2D now
    delete(h1)
    h1=subplot(2,3,1);
    hold on;
    axis equal;
    xlabel('x');
    ylabel('y');
    xlim([-12 12]);
    ylim([-12 12]);
    grid on;

    h2 = subplot(2,3,2);
    hold on;
    xlabel('time (ms)');
    ylabel('M_x,M_y');
    xlim([0 (1.5.*Ts)+0.32])
    ylim([-1 1]);
    grid on; 

    h3 = subplot(2,3,3);
    hold on;
    xlabel('time (ms)');
    ylabel('MTrans');
    xlim([0 (1.5.*Ts)+0.32])
    ylim([-0.5 0.5]);
    grid on; 

    h4 = subplot(2,3,4);
    hold on;
    xlabel('time (ms)');
    ylabel('G_x,G_y');
    xlim([0, 0.32+(1.5.*Ts)]);
    ylim([-GMax GMax]);
    grid on; 

    h5 = subplot(2,3,5);
    hold on;
    xlabel('time (ms)');
    ylabel('k_x,k_y');
    xlim([0, 0.32+(1.5.*Ts)]);
    ylim([-3 3]);
    grid on;

    h6 = subplot(2,3,6);
    hold on;
    xlabel('k_x');
    ylabel('k_y');
    xlim([-2 2]);
    ylim([-2 2]);
    grid on;

    set(0,'DefaultLegendAutoUpdate','off')

    vecMus2start=vecMusReset(1:2,:);
    T2=10;

    stage=2;
    Gy1=Gstep;
    kx1=0;
    Gx1=-4.6;

    wy=zeros(1,no_of_spins);
    wx=zeros(1,no_of_spins);
    w=zeros(1,no_of_spins);
    for i = 1:no_of_spins
        wy(i)=Gy1.*(vecMus0orig(2,i));
        wx(i)=Gx1.*(vecMus0orig(1,i));
        w(i) = wy(i)+wx(i);
    end
    


    for i = 1:N./2

        t_from_start=0.32+(i.*(Ts./(N)));
        t=(i.*(Ts./(N)));
        ky1=0.1.*Gy1.*t;
        kx1=0.1.*Gx1.*t;


        for k = 1:no_of_spins
            %Moving initial vector to near origin
            vecMus2init(1,k)=vecMus2start(1,k)-vecMus0orig(1,k);
            vecMus2init(2,k)=vecMus2start(2,k)-vecMus0orig(2,k);

            %Bloch equations
            vecMus2rot(1,k)=exp((-t)./T2).*((vecMus2init(1,k).*cos(w(k).*t))+((vecMus2init(2,k).*(sin(w(k).*t)))));
            vecMus2rot(2,k)=exp((-t)./T2).*((vecMus2init(2,k).*cos(w(k).*t))-((vecMus2init(1,k).*(sin(w(k).*t)))));

            %Resetting position to actual
            vecMus2reset(1,k)=vecMus2rot(1,k)+vecMus0orig(1,k);
            vecMus2reset(2,k)=vecMus2rot(2,k)+vecMus0orig(2,k);       
        end

        hVecMu = plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus2reset);
        legend(h1,'hide')

        %Calculating transverse magnetisation
        for i = 1:no_of_spins    
            Mx(i)=vecMus2reset(1,i)-vecMus0orig(1,i);
            My(i)=vecMus2reset(2,i)-vecMus0orig(2,i);
        end
        Mxtot=sum(Mx./(no_of_spins.*mu));
        Mytot=sum(My./(no_of_spins.*mu));

        hMTrans = plot_Task1_MTrans(t_from_start,h2,Mxtot,Mytot);

        MTrans=Mxtot+Mytot./2;
        plot(h3,t_from_start,MTrans,'Color', 'k', 'Marker', '.', 'MarkerSize', 10)
        hold on


        plot(h4,t_from_start,Gx1,'Color','b','Marker', '.', 'MarkerSize', 10,'DisplayName','M_x');
        %     legend('k_t_o_t');
        hold on
        plot(h4,t_from_start,Gy1,'Color','r','Marker', '.', 'MarkerSize', 10,'DisplayName','M_y');
        hold on


        plot(h5,t_from_start,kx1,'Color','b','Marker', '.', 'MarkerSize', 10,'DisplayName','k_x');
        %     legend('k_t_o_t');
        hold on
        plot(h5,t_from_start,ky1,'Color','r','Marker', '.', 'MarkerSize', 10,'DisplayName','k_y');
        hold on

        plot_kx_ky(h6,kx1,ky1)

        pause(0.001);

        ClearLinesFromAxes(h1);
    end
    plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus2reset);

    %%
    %-Gx is on for Ts, this is the rephasing lobe of the readout gradient 

    vecMus3start=vecMus2reset;
    Gx2=4.6;
    ky2=0+ky1;
    Gy2=0;
    
    wx=zeros(no_of_spins);
    for i = 1:no_of_spins
        wx(i)=Gx2.*(vecMus0orig(1,i));
    end 

    for i = 1:N

        t_from_start=(0.32)+(Ts./2)+(i.*(Ts./N));
        t=(i.*(Ts./N));
        kx2=(0.1.*Gx2.*t)+kx1;

        for k = 1:no_of_spins
            %Moving initial vector to near origin
            vecMus3init(1,k)=vecMus3start(1,k)-vecMus0orig(1,k);
            vecMus3init(2,k)=vecMus3start(2,k)-vecMus0orig(2,k);

            %Bloch equations
            vecMus3rot(1,k)=exp((-t)./T2).*((vecMus3init(1,k).*cos(wx(k).*t))+((vecMus3init(2,k).*(sin(wx(k).*t)))));
            vecMus3rot(2,k)=exp((-t)./T2).*((vecMus3init(2,k).*cos(wx(k).*t))-((vecMus3init(1,k).*(sin(wx(k).*t)))));

            %Resetting position to actual
            vecMus3reset(1,k)=vecMus3rot(1,k)+vecMus0orig(1,k);
            vecMus3reset(2,k)=vecMus3rot(2,k)+vecMus0orig(2,k);       
        end

        hVecMu = plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus3reset);
        legend(h1,'hide')

            %Calculating transverse magnetisation
        for i = 1:no_of_spins    
            Mx(i)=vecMus3reset(1,i)-vecMus0orig(1,i);
            My(i)=vecMus3reset(2,i)-vecMus0orig(2,i);
        end
        Mxtot=sum(Mx./(no_of_spins.*mu));
        Mytot=sum(My./(no_of_spins.*mu));

        hMTrans = plot_Task1_MTrans(t_from_start,h2,Mxtot,Mytot);

        MTrans=Mxtot+Mytot./2;
        plot(h3,t_from_start,MTrans,'Color', 'k', 'Marker', '.', 'MarkerSize', 10)
        hold on  

        plot(h4,t_from_start,Gx2,'Color','b','Marker', '.', 'MarkerSize', 10,'DisplayName','M_x');
        %     legend('k_t_o_t');
        hold on
        plot(h4,t_from_start,Gy2,'Color','r','Marker', '.', 'MarkerSize', 10,'DisplayName','M_y');
        hold on


        plot(h5,t_from_start,kx2,'Color','b','Marker', '.', 'MarkerSize', 10,'DisplayName','k_x');
        %     legend('k_t_o_t');
        hold on
        plot(h5,t_from_start,ky2,'Color','r','Marker', '.', 'MarkerSize', 10,'DisplayName','k_y');
        hold on    

        plot_kx_ky(h6,kx2,ky2)

        pause(0.01);

        ClearLinesFromAxes(h1);
    end
    
    plotSpin3D_2Dgrid(stage,no_of_spins,t_from_start,h1,vecMus0orig(1:2,:),vecMus3reset);
    
    if Gstep < 4.6
        delete(h1)
        delete(h2)
        delete(h3)
        delete(h4)
        delete(h5)
    end

end











