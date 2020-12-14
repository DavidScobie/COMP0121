function objHandle = plotSpin3D_1Dline(stage,no_of_spins,t,figHandle,vecMus,colors)

    colors=['b','r'];

    if stage == 1
    
        
        j=size(vecMus);
        k=j(2);
        for i = 1:k
            objHandle(1)=plot3(figHandle, [i-((no_of_spins+1)./2) vecMus(1,i)], [0 vecMus(2,i)],...
                [0 vecMus(3,i)], 'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);
            %Plotting the points at the end of the spin vectors.
            objHandle(2)=plot3(figHandle,vecMus(1,i),vecMus(2,i),vecMus(3,i),...
                'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);
        end
    end
    
    if stage == 2 
        
        j=size(vecMus);
        k=j(2);
        for i = 1:k
            objHandle(1)=plot(figHandle, [i-((no_of_spins+1)./2) vecMus(1,i)], [0 vecMus(2,i)],...
                 'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);
            %Plotting the points at the end of the spin vectors.
            objHandle(2)=plot(figHandle,vecMus(1,i),vecMus(2,i),...
                'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);            
        end     
    title('ADC off')   


% legend('hide')
end
