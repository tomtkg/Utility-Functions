function obj3d(data,name,label)
%Objective space in 3 dimensions
    if nargin == 2
        label = ["\it f\rm_1","\it f\rm_2","\it f\rm_3"];
    end
    figure('Position',[100 100 300 300],'Visible','on');
    set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
        'Color','none','Box','on','View',[135 30],'LooseInset', get(gca, 'TightInset'));
    plot3(data(:,1),data(:,2),data(:,3),'o','MarkerSize',10, ...
        'Markerfacecolor',[.7 .7 .7],'Markeredgecolor',[.4 .4 .4]);
    xlim([-0.05 1.05]); xlabel(label(1),'position',[0.4,1.2,-0.15]);
    ylim([-0.05 1.05]); ylabel(label(2),'position',[1.2,0.4,-0.15]);
    zlim([-0.05 1.05]); zlabel(label(3),'position',[0.4,-0.77,0.5],'Rotation',0);
    zticks([0 0.5 1]); axis square;
    print(gcf,'-dsvg','-r600',sprintf('%s.svg', name));
    close;
end
