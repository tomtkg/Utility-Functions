function Geometry()

    rng('default'); X = cell(3); Y = cell(3);
    for i = 1 : 3
        X{i} = rand(20,1); Y{i} = rand(20,1);
    end
    names = ["scatter","graph","graphA","graphB","tsp","kmeans", ...
        "voronoi","triplot","convhull","boundary","boundaryA", ...
        "boundaryB","alphaShape","alphaShapeA","alphaShapeB"];

    for i = 1 : 3
        x = X{i}; y = Y{i};
        for j = 1 : 15
            % Pre-proces
            figure('Position',[100 100 400 400],'Visible','on');
            set(gca,'Fontname','Times New Roman','FontSize',13, ...
                'NextPlot','add','Color','none','Box','on', ...
                'LooseInset',get(gca,'TightInset'));
            axis square; hold on
            xlim([-0.05 1.05]); ylim([-0.05 1.05]);
            yticks([0 0.2 0.4 0.6 0.8 1]);
            
            % Drawing proces
            feval(sprintf('func%d',j), x, y);
            scatter(x,y,'r','filled');
            
            % Post-proces
            name = sprintf('%s%d.svg', names(j), i);
            print(gcf, '-dsvg', '-r600', name); close
        end
    end
end
function func1(x,y) % 完全グラフ
end
function func2(x,y) % 完全グラフ
    G = graph(ones(20),'omitselfloops');
    plot(G,'XData',x,'YData',y,'NodeLabel',{});
end
function p = func3(x,y) % 有向グラフ
    [~,C] = pdist2([x,y],[x,y],'euclidean','Smallest',2);
    G = digraph(C(1,:),C(2,:));
    plot(G,'XData',x,'YData',y,'NodeLabel',{});
end
function func4(x,y) % 有向グラフ
    [~,C] = pdist2([x,y],[x,y],'euclidean','Smallest',3);
    G = digraph([C(1,:); C(1,:)], [C(2,:); C(3,:)]);
    plot(G,'XData',x,'YData',y,'NodeLabel',{});
end
function func5(x,y) % 最短ハミルトン閉路
    if x(1) > 0.8
        i = 1; 
    elseif x(1) > 0.4
        i = 2; 
    else
        i = 3;
    end
    load tsp.mat G
    plot(G{i},'XData',x,'YData',y,'NodeLabel',{});
end
function p = func6(x,y) % クラスタリング
    [X,Y] = meshgrid(0:0.01:1);
	[~,C] = kmeans([x,y],5,'MaxIter',1000);
	idx = kmeans([X(:),Y(:)],5,'MaxIter',0,'Start',C);
	gscatter(X(:),Y(:),idx); legend('off');
	scatter(C(:,1),C(:,2),'k');
end
function func7(x,y) % ボロノイ図
    voronoi(x,y);
end
function func8(x,y) % ドロネー図
    triplot(delaunayTriangulation(x,y));
end
function func9(x,y) % 凸包
    k = convhull(x,y);
	plot(x(k),y(k));
end
function func10(x,y) % 点群境界
    k = boundary(x,y);
	plot(x(k),y(k));
end
function func11(x,y) % 点群境界
    k = boundary(x,y,0.3);
	plot(x(k),y(k));
end
function func12(x,y) % 点群境界
    k = boundary(x,y,0.8);
	plot(x(k),y(k));
end
function func13(x,y) % アルファシェイプ
    plot(alphaShape(x,y));
end
function func14(x,y) % アルファシェイプ
    shp = alphaShape(x,y);
    shp.Alpha = 0.5 * shp.Alpha;
    plot(shp);
end
function func15(x,y) % アルファシェイプ
    shp = alphaShape(x,y);
    shp.Alpha = 1.5 * shp.Alpha;
    plot(shp);
end
