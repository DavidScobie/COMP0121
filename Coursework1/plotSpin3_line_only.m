function objHandle = plotSpin3_line_only(i,figHandle,vecMu,B1,vecMu_up,colors)

% if nargin <3
    colors=['b','r'];
% end

objHandle(1)=plot3(figHandle, [0 vecMu(1)], [0 vecMu(2)],...
    [0 vecMu(3)],'Color',colors(1),  'Linestyle', '-', 'LineWidth', 2);

objHandle(2)=plot3(figHandle, [0 B1(1)], [0 B1(2)],...
    [0 B1(3)],'Color',colors(2),  'Linestyle', '-', 'LineWidth', 2);

objHandle(3)=plot3(figHandle, [0 vecMu_up(1)], [0 vecMu_up(2)],...
    [0 vecMu_up(3)],'Color',colors(1),  'Linestyle', '-', 'LineWidth', 2);

if i==200
    delete(objHandle(1))
    delete(objHandle(2))
end
end