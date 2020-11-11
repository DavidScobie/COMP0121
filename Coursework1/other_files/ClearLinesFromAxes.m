function ClearLinesFromAxes(axesToClear)
    axesHandlesToChildObjects = findobj(axesToClear, 'Type', 'line');
    if ~isempty(axesHandlesToChildObjects)
      delete(axesHandlesToChildObjects);
    end  
    return;