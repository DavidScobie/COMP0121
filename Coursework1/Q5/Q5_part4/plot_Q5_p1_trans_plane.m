function objHandle = plot_Q5_p1_trans_plane(stage,figHandle,vecMu,vecMus,colors)

colors=['b','r'];

    if stage==1

    
        objHandle(1)=plot(figHandle, [0 vecMu(1)], [0 vecMu(2)],...
            'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);

        objHandle(2)=plot(figHandle,vecMu(1),vecMu(2),...
            'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);
        
        
    elseif stage==2

        vecMuSize=size(vecMus);

        for i=1:vecMuSize(1)
            
            
                
                objHandle(i)=plot(figHandle, [0 vecMus(i,1)], [0 vecMus(i,2)],...
            'Color',colors(1), 'Linestyle', '-', 'LineWidth', 2);
            
            
                
                objHandle(i+vecMuSize(1))=plot(figHandle,vecMus(i,1),vecMus(i,2),...
            'Color', colors(2), 'Marker', '.', 'MarkerSize', 10);
        
            

        end
    end
end