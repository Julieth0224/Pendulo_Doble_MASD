function Pendulos_sin_rozamiento(ti,tf,ML, CI)
%%%% Multiples pendulos dobles sin rozamiento

g = 9.8;

lims = max(ML(:,2)) + max(ML(:,4)) + 1;

[f,c] = size(ML);
  
P = zeros([4*f 5000]);

T = zeros([1 f]);


for p = 1:f
    
    ci = CI(p,:);
    ml = ML(p,:);
    vec = [ci ml];
    [t,x] = ode45(@ODExx,[ti,tf],vec);
    T(1,p) = length(t);

    Pp = zeros([4 length(t)]);
    t1 = x(:,1);
    tt1 = x(:,2);
    t2 = x(:,3);
    tt2 = x(:,4);
    
    x1 = zeros([1 length(t)]);
    y1 = zeros([1 length(t)]);
    x2 = zeros([1 length(t)]);
    y2 = zeros([1 length(t)]);

    xx1 = zeros([1 length(t)]);
    yy1 = zeros([1 length(t)]);
    xx2 = zeros([1 length(t)]);
    yy2 = zeros([1 length(t)]);
    
    L1 = ML(p,2);
    L2 = ML(p,4);

    for q = 1:length(t)

        x1(q) = L1*sin(t1(q));
        y1(q) = -L1*cos(t1(q));
        x2(q) = x1(q) + L2*sin(t2(q));
        y2(q) = y1(q) - L2*cos(t2(q));
        
        xx1(q) = tt1(q)*L1*cos(t1(q));
        yy1(q) = tt1(q)*L1*sin(t1(q));
        xx2(q) = xx1(q) + tt2(q)*L2*cos(t2(q));
        yy2(q) = yy1(q) + tt2(q)*L2*sin(t2(q));

    end
    
    Pp(1,:) = x1;
    Pp(2,:) = y1;
    Pp(3,:) = x2;
    Pp(4,:) = y2;
    
    P(4*(p-1)+1:4*p,1:length(t)) = Pp;
    
end

t_max = max(T);

%Quitar ceros


for w = 1:f
    indx = find(T < t_max);
    for h = 1:length(indx)
        last = P(4*(indx(h)-1)+1:4*(indx(h)-1)+4, T(w));
        P(4*(indx(h)-1)+1:4*(indx(h)-1)+4, T(w)+1:t_max) = repmat(last, 1,t_max-T(w));

    end 
end


v = VideoWriter('prueba_multiple.avi');
v.FrameRate=20;
open(v);

sRGB = colormap(lines);
for n = 1:t_max
    for d = 1:f
        pf_x1 = P(4*(d-1)+1,1:t_max);
        pf_y1 = P(4*(d-1)+2,1:t_max);
        pf_x2 = P(4*(d-1)+3,1:t_max);
        pf_y2 = P(4*d,1:t_max);
        A = [pf_x1(n),0];
        B = [pf_y1(n),0];    
        X = [pf_x1(n) pf_x2(n)];
        Y = [pf_y1(n) pf_y2(n)];
        
        plot(pf_x1(n),pf_y1(n),'Marker','.','MarkerSize',20,'Color',sRGB(d,:));
        hold on
        line(X,Y,'LineWidth',1.5,'Color',sRGB(d,:));
        line(A,B,'LineWidth',1.5,'Color',sRGB(d,:));
        plot(pf_x1(1:n),pf_y1(1:n), 'LineStyle', '-.','MarkerSize',1,'Color',sRGB(d,:));
        plot(pf_x2(n),pf_y2(n),'Marker','.','MarkerSize',20,'Color',sRGB(d,:));
        plot(pf_x2(1:n),pf_y2(1:n),'LineStyle', '--','MarkerSize',1,'Color',sRGB(d,:));
    end
    hold off
    grid on
    xlim([-lims, lims]); 
    ylim([-lims, lims]);   
    F = getframe(gcf); 
    writeVideo(v,F); 
end

close(v);
end

