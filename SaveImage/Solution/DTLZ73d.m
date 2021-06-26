function DTLZ73d(data,name)
%Objective space in 3 dimensions
    figure('Position',[100 100 500 500],'Visible','on');
    set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
        'Color','none','Box','on','View',[135 30],'LooseInset', get(gca, 'TightInset'));
    plot3(data(:,1),data(:,2),data(:,3),'o','MarkerSize',8, ...
        'Markerfacecolor',[.7 .7 .7],'Markeredgecolor',[.4 .4 .4]);
    xlim([-0.043 0.9024]); xlabel('\it f\rm_1','position',[0.75,0,1]);
    ylim([-0.043 0.9024]); ylabel('\it f\rm_2','position',[0,0.75,1]);
    zlim([2.4447 6.1693]); zlabel('\it f\rm_3','position',[0,-1,3.3],'Rotation',0);
    zticks([3 4 5 6]); axis square;
    exportgraphics(gcf,[name,'.pdf'],'BackgroundColor','none','ContentType','vector');
    exportgraphics(gcf,[name,'.emf'],'BackgroundColor','none','ContentType','vector');
    savefig([name,'.fig']);
    close;
end
