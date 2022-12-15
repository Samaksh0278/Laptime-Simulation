v_sactual=zeros(1,N);
v_sactual(1)=v_max;
m=2;dummy=v_max;
for i=1:1:580
    
    while(s_t2(i)<m)
        
            v_sactual(m)=dummy;
            m=m+1;
    end
    dummy=v_t2(i);
    
end
    