function WFG3d(data,name)
%Objective space in 3 dimensions
    figure('Position',[100 100 500 500],'Visible','on');
    set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
        'Color','none','Box','on','View',[135 30],'LooseInset', get(gca, 'TightInset'));
    plot3(data(:,1),data(:,2),data(:,3),'o','MarkerSize',8, ...
        'Markerfacecolor',[.7 .7 .7],'Markeredgecolor',[.4 .4 .4]);
    xlim([-0.1 2.1]); xlabel('\it f\rm_1','position',[0.1,3.2,-2.6]);
    ylim([-0.2 4.2]); ylabel('\it f\rm_2','position',[1.3,-0.5,-3.5]);
    zlim([-0.3 6.3]); zlabel('\it f\rm_3','position',[1.3,-2,4.4],'Rotation',0);
    axis square;
    exportgraphics(gcf,[name,'.pdf'],'BackgroundColor','none','ContentType','vector');
    exportgraphics(gcf,[name,'.emf'],'BackgroundColor','none','ContentType','vector');
    savefig([name,'.fig']);
    close;
end
