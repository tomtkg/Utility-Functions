function axGen(method,data,name,label,pos,y)
%Axis is Generation
    X = 1 : size(data,2);
    figure('Position',[100 100 500 500],'Visible','on');
    set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
        'Color','none','Box','on','LooseInset', get(gca, 'TightInset'));
    BGPlot(method,X,data);
    C = {'k','b','r'};
    for i = 1:size(data,1)/3
        p(i) = plot(X', data(3*i,:)',C{i});
    end
    legend(p,label,'Location',pos,'Color','none');
    xlabel('\it Generation'); ylabel(['\it ',y]);
    axis square;
    exportgraphics(gcf,[name,y,num2str(method),'Gen.pdf'],'BackgroundColor','none','ContentType','vector');
    exportgraphics(gcf,[name,y,num2str(method),'Gen.emf'],'BackgroundColor','none','ContentType','vector');
    savefig([name,y,num2str(method),'Gen.fig']);
    close;
end
function BGPlot(method,X,data)
%Background Plot
    switch method
        case 2
            C = {'k:','b:','r:'};
            for i = 1:size(data,1)/3
                plot(X', data(3*i-2,:)',C{i});
                plot(X', data(3*i-1,:)',C{i});
            end
        case 3
            C = {'k','b','r'};
            for i = 1:size(data,1)/3
                patch([X flip(X)]',[data(3*i-2,:) flip(data(3*i-1,:))]',...
                    C{i},'FaceAlpha',.1,'EdgeColor','none');
            end
    end
end
