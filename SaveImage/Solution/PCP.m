function PCP(data,name)
%Parallel Coordinate Plot
    figure('Position',[100 100 500 500],'Visible','on');
    set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
        'Color','none','Box','on','LooseInset', get(gca, 'TightInset'));
    Label = repmat([0.99,2:size(data,2)-1,size(data,2)+0.01],size(data,1),1);
    data(2:2:end,:)  = fliplr(data(2:2:end,:));
    Label(2:2:end,:) = fliplr(Label(2:2:end,:));
    plot(reshape(Label',[],1),reshape(data',[],1),'-k','LineWidth',1);
    xlim([1 size(data,2)]); xlabel('Dimension No.'); ylabel('Value');
    axis square;
    exportgraphics(gcf,[name,'.pdf'],'BackgroundColor','none','ContentType','vector');
    exportgraphics(gcf,[name,'.emf'],'BackgroundColor','none','ContentType','vector');
    savefig([name,'.fig']);
    close;
end
