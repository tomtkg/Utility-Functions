function Compare()
    run = 101; max = 100; D = 2;
    tmp = zeros(1,run);
    data = zeros(3*3,max);
    
    [x1,x2] = meshgrid(0:1/99:1); % 2次元の格子座標
    Y = [x1(:),x2(:)];            % 点群Y
    YH = sum(sin(Y.*10),2);       % 点群Yの高さ（真値）
    
    func = {
        @(N,D)rand(N,D), ...
        @(N,D)lhsdesign(N,D), ...
        @(N,D)lhs(N,D)};
    rng(1);
    for N = 20 : max
        for i = 1 : 3
            for j = 1 : run
                X = func{i}(N,D);                % 点群X
                XH = sum(sin(X.*10),2);          % 点群Xの高さ
                % EH = sim(newrbe(X',XH'),Y')';    % 点群Yの高さ（推定値）
                EH = predict(fitrgp(X,XH),Y);    % 点群Yの高さ（推定値）
                tmp(j) = sum(abs(EH-YH),'all'); % 誤差の合計
            end
            data(3*i-2:3*i,N) = quantile(tmp,[0.25 0.75 0.5]);
        end
    end
    
    data = data(:,20:max); X = 20 : max; C = {'k','b','r'};
    label = {'rand function', ...
        'lhsdesign fuction', ...
        'latin hypercube sampling'};
 
    set(gca,'Fontname','Times New Roman','FontSize',13,'NextPlot','add', ...
        'Color','none','Box','on','LooseInset', get(gca, 'TightInset'));
    for i = 1 : 3
        patch([X flip(X)]',[data(3*i-2,:) flip(data(3*i-1,:))]', ...
            C{i},'FaceAlpha',.1,'EdgeColor','none');
    end
    for i = 1 : 3
        p(i) = plot(X', data(3*i,:)',C{i});
    end
    legend(p,label,'Color','w'); grid on
    xlabel('Number of point clouds');
    ylabel('Sum of estimation errors');
    xlim([20 max]); set(gca,'YScale','log');
    exportgraphics(gcf,'compare2.png'); close
end
function X = lhs(N,D)
    [~,X] = sort(rand(N,D),1);
    X = (rand(N,D)+X-1)/N;
end
