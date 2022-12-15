function t_s = transpose1(v_s)
%% transposes the v(s) to t(s) 
t_s=0;
for i=1:1:(N-1)
    a=(v_s(i+1)+v_s(i));
    t_s=[t_s,(t_s(i)+(2/a))];
end
