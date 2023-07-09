function LHS()
    N = 50; D = 2;
    name = {'rand','lhsd','lhs'};
    func = {
        @(N,D)rand(N,D), ...
        @(N,D)lhsdesign(N,D), ...
        @(N,D)lhs(N,D)};
    
    for i = 1 : 3
        rng(1);
        X = func{i}(N,D);
        saveImage1(X,name{i}); % scatterhist
        saveImage3(X,name{i}); % newrbe
        saveImage4(X,name{i}); % fitrgp
    end
    
    D = 5;
    for i = 1 : 3
        rng(1);
        X = func{i}(N,D);
        saveImage2(X,D,name{i}); % plotmatrix
    end    
end
function X = lhs(N,D)
    [~,X] = sort(rand(N,D),1);
    X = (rand(N,D)+X-1)/N;
end
function saveImage1(X,name) % scatterhist
    figure('Position',[100 100 500 500],'Visible','on');
    p = scatterhist(X(:,1),X(:,2),'MarkerSize',4,...
        'Location','NorthEast','Direction','out');
    p(2).Children.BinWidth = 0.04; p(2).YLim = [0 3];
    p(3).Children.BinWidth = 0.04; p(3).YLim = [0 3];
    xlim([0 1]); xlabel('\it x\rm_1','Fontname','Times New Roman');
    ylim([0 1]); ylabel('\it x\rm_2','Fontname','Times New Roman');
    yticks([0 0.2 0.4 0.6 0.8 1]); axis square; grid on
    exportgraphics(gcf,[name,'.png']); close
end
function saveImage2(X,D,name) % plotmatrix
    figure('Position',[100 100 500 500],'Visible','on');
    set(gca,'Fontname','Times New Roman','FontSize',15, ...
        'NextPlot','add','LooseInset', get(gca, 'TightInset'));
    [S,AX,~,H,HAx] = plotmatrix(X);
    set(S,'MarkerSize',6); set(H,'BinWidth',0.04);
    for i = 1 : D
        for j = 1 : D
            AX(i,j).XLim = [-0.05 1.05];
            AX(i,j).YLim = [-0.05 1.05];
        end
        HAx(i).XLim = [-0.05 1.05];
        HAx(i).YLim = [0 6.2];
        label = ['\it x\rm_',num2str(i)];
        xlabel(AX(D,i),label,'Fontname','Times New Roman');
        ylabel(AX(i,1),label,'Fontname','Times New Roman');
    end
    exportgraphics(gcf,[name,'2.png']); close
end
function saveImage3(X,name) % newrbe
    XH = sum(sin(X.*10),2);       % 点群Xの高さ
    [x1,x2] = meshgrid(0:1/99:1); % 2次元の格子座標
    Y = [x1(:),x2(:)];            % 点群Y
    
    EH = sim(newrbe(X',XH'),Y')'; % 点群Yの高さ（推定値）
    YH = sum(sin(Y.*10),2);       % 点群Yの高さ（真値）
    disp(sum(abs(EH-YH),'all'));  % 誤差（推定値と真値の差）の合計を表示
    
    figure('Position',[100 100 500 500],'Visible','on');
    set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
        'Box','on','LooseInset', get(gca, 'TightInset'),'View',[-45,30]);
    surf(x1,x2,reshape(EH,100,100),'FaceAlpha',.5,'EdgeColor','none');
    plot3(X(:,1),X(:,2),XH,'r.');
    xlim([0 1]); xlabel('\it x\rm_1','position',[1.2,0.6,-4.5]);
    ylim([0 1]); ylabel('\it x\rm_2','position',[0.6,1.2,-4.5]);
    zlim([-2.05 2.05]); grid on
    exportgraphics(gcf,[name,'3.png']); close
    
    figure('Position',[100 100 500 500],'Visible','on');
    set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
        'Box','on','LooseInset', get(gca, 'TightInset'));
    imagesc(x1(:),x2(:),reshape(EH,100,100));
    plot(X(:,1),X(:,2),'r.','MarkerSize',12);
    xlim([0 1]); xlabel('\it x\rm_1');
    ylim([0 1]); ylabel('\it x\rm_2');
    yticks([0 0.2 0.4 0.6 0.8 1]); axis square;
    exportgraphics(gcf,[name,'4.png']); close
end
function saveImage4(X,name)
    XH = sum(sin(X.*10),2);       % 点群Xの高さ
    [x1,x2] = meshgrid(0:1/99:1); % 2次元の格子座標
    Y = [x1(:),x2(:)];            % 点群Y
    
    EH = predict(fitrgp(X,XH),Y); % 点群Yの高さ（推定値）
    YH = sum(sin(Y.*10),2);       % 点群Yの高さ（真値）
    disp(sum(abs(EH-YH),'all'));  % 誤差（推定値と真値の差）の合計を表示
    
    figure('Position',[100 100 500 500],'Visible','on');
    set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
        'Box','on','LooseInset', get(gca, 'TightInset'),'View',[-45,30]);
    surf(x1,x2,reshape(EH,100,100),'FaceAlpha',.5,'EdgeColor','none');
    plot3(X(:,1),X(:,2),XH,'r.');
    xlim([0 1]); xlabel('\it x\rm_1','position',[1.2,0.6,-4.5]);
    ylim([0 1]); ylabel('\it x\rm_2','position',[0.6,1.2,-4.5]);
    zlim([-2.05 2.05]); grid on
    exportgraphics(gcf,[name,'5.png']); close
    
    figure('Position',[100 100 500 500],'Visible','on');
    set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
        'Box','on','LooseInset', get(gca, 'TightInset'));
    imagesc(x1(:),x2(:),reshape(EH,100,100));
    plot(X(:,1),X(:,2),'r.','MarkerSize',12);
    xlim([0 1]); xlabel('\it x\rm_1');
    ylim([0 1]); ylabel('\it x\rm_2');
    yticks([0 0.2 0.4 0.6 0.8 1]); axis square;
    exportgraphics(gcf,[name,'6.png']); close
end
