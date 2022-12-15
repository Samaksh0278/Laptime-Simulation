function v_t = transpose2(v_s,t_s)
%% This gives v(t) with time steps of 0.1 s 
i=1;
m=1;
v_t=zeros(1,1000);
t_s=[t_s,10000];
while(i<1000)
    counter=0;
    v_dummy=0;
    while(t_s(i)<(m*0.1))
        
        v_dummy=v_dummy+v_s(i);
        counter=counter+1;
        i=i+1;
    end
    if counter>0
         v_t(m)=(v_dummy/counter);
        
    else
        v_t(m)=v_t(m-1);
    end
    
    m=m+1;
end

    
