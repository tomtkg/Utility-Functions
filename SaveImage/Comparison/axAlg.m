function axAlg(data,name,label,y)
%Axis is Algorithm
    figure('Position',[100 100 500 500],'Visible','on');
    set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
        'Color','none','Box','on','LooseInset', get(gca, 'TightInset'));
    boxplot(data,'Labels',label);
    ylabel(['\it ',y]);
    axis square;
    exportgraphics(gcf,[name,y,'Alg.pdf'],'BackgroundColor','none','ContentType','vector');
    exportgraphics(gcf,[name,y,'Alg.emf'],'BackgroundColor','none','ContentType','vector');
    savefig([name,y,'Alg.fig']);
    close;
end
