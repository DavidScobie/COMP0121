function objHandle = plotSpin3D_1Dline(stage,no_of_spins,t,figHandle,origin_points,vecMus,colors)

    colors=['b','r'];

    if stage == 1
    
        
        j=size(vecMus);
        k=j(2);
        for i = 1:k
            objHandle(1)=plot3(figHandle, [origin_points(1,i) vecMus(1,i)], [origin_points(2,i) vecMus(2,i)],...
                [origin_points(3,i) vecMus(3,i)], 'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);
            %Plotting the points at the end of the spin vectors.
            objHandle(2)=plot3(figHandle,vecMus(1,i),vecMus(2,i),vecMus(3,i),...
                'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);
        end
    end
    
    if stage == 2 
        
        j=size(vecMus);
        k=j(2);
        for i = 1:k
            objHandle(1)=plot(figHandle, [origin_points(1,i) vecMus(1,i)], [origin_points(2,i) vecMus(2,i)],...
                 'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);
            %Plotting the points at the end of the spin vectors.
            objHandle(2)=plot(figHandle,vecMus(1,i),vecMus(2,i),...
                'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);            
        end     

title(['t=',num2str(t,'%.2f'),'ms'])
% legend('hide')
end