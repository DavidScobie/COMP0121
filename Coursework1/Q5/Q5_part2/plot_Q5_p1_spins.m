function objHandle = plot_Q5_p1_spins(stage,figHandle,vecMu,vecMus,colors)


    colors=['b','r'];

    if stage==1

        objHandle(1)=plot3(figHandle, [0 vecMu(1)], [0 vecMu(2)],...
            [0 vecMu(3)],'Color',colors(1),  'Linestyle', '-', 'LineWidth', 2);

    elseif stage==2

        vecMuSize=size(vecMus);

        for i=1:vecMuSize(1)


            objHandle(i)=plot3(figHandle, [0 vecMus(i,1)], [0 vecMus(i,2)],...
                [0 vecMus(i,3)],'Color',colors(1),  'Linestyle', '-', 'LineWidth', 2);
            hold on


        end
    end

end