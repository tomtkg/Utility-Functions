function var2d(data,name,label)
%Variable space in 2 dimensions
    if nargin == 2
        label = ["\it x\rm_1","\it x\rm_2"];
    end
    figure('Position',[100 100 500 500],'Visible','on');
    set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
        'Color','none','Box','on','LooseInset', get(gca, 'TightInset'));
    plot(data(:,1),data(:,2),'o','MarkerSize',8, ...
        'Markerfacecolor',[.7 .7 .7],'Markeredgecolor',[.4 .4 .4]);
    Min = min(data,[],1); Max = max(data,[],1); D = (Max-Min)/20;
    xlim([Min(1)-D(1) Max(1)+D(1)]); ylim([Min(2)-D(2) Max(2)+D(2)]);
    xlabel(label(1)); ylabel(label(2));
    axis square;
    exportgraphics(gcf,[name,'.pdf'],'BackgroundColor','none','ContentType','vector');
    exportgraphics(gcf,[name,'.emf'],'BackgroundColor','none','ContentType','vector');
    savefig([name,'.fig']);
    close;
end
