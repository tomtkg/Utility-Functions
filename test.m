function test()
    cd(fileparts(mfilename('fullpath')));
    addpath(genpath(cd));
    rng('default');
    
    for i = 1 : 3
        figure('Position',[100 100 400 400],'Visible','on');
        set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
            'Color','none','Box','on','LooseInset', get(gca, 'TightInset'));
        axis square; hold on
        xlim([-0.05 1.05]); ylim([-0.05 1.05]);
        yticks([0 0.2 0.4 0.6 0.8 1]);
        x = rand(20,1); y = rand(20,1);
        
        %G = graph(ones(20));
        %[~,C] = pdist2([x,y],[x,y],'euclidean','Smallest',2);
        %G = digraph(C(1,:),C(2,:));
        %plot(G,'XData',x,'YData',y,'NodeLabel',{});
        
        %[X,Y] = meshgrid(0:0.01:1);
        %[~,C] = kmeans([x,y],4,'MaxIter',1000);
        %idx = kmeans([X(:),Y(:)],4,'MaxIter',0,'Start',C);
        %gscatter(X(:),Y(:),idx); legend('off');
        
        %voronoi(x,y);
        %triplot(delaunayTriangulation(x,y));
        %k = convhull(x,y); plot(x(k),y(k));
        %k = boundary(x,y,0.8); plot(x(k),y(k));
        %a = criticalAlpha(alphaShape(x,y),'all-points');
        %plot(alphaShape(x,y,a*1.5));
        scatter(x,y,'r','filled');
        print(gcf,'-dsvg','-r600',sprintf('kmeans%d.svg', i));
        close;
    end
end
