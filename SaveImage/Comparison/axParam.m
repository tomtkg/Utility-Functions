function axParam(X,data,name,label,pos,y,x)
%Axis is Parameter
    figure('Position',[100 100 500 500],'Visible','on');
    set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
        'Color','none','Box','on','LooseInset', get(gca, 'TightInset'));
    C = {'ko-','bo-','ro-'};
    for i = 1:size(data,1)/3
        Y = data(3*i,:)';
        N = Y - data(3*i-2,:)';
        P = data(3*i-1,:)' - Y;
        errorbar(X',Y,N,P,C{i});
    end
    legend(label,'Location',pos,'Color','none');
    Min = min(X,[],'all'); Max = max(X,[],'all');
    D = (Max-Min)/20; xlim([Min-D Max+D]);
    Min = min(data,[],'all'); Max = max(data,[],'all');
    D = (Max-Min)/20; ylim([Min-D Max+D]);
    xlabel(x); ylabel(['\it ',y]);
    axis square;
    exportgraphics(gcf,[name,y,'Param.pdf'],'BackgroundColor','none','ContentType','vector');
    exportgraphics(gcf,[name,y,'Param.emf'],'BackgroundColor','none','ContentType','vector');
    savefig([name,y,'Param.fig']);
    close;
end
