function z = rtp(x, y) 
%x = polar/rect value 
%y = desired output (radians 'r' or degrees 'd')

%rectangular to polar
if (y == 'd')
    deg = angle(x)*180/pi;
    output_str = [num2str(abs(x)) ' < ' num2str(deg)];
    z = output_str;
end

if (y == 'r')
    output_str = [num2str(abs(x)) ' < ' num2str(angle(x))];
    z = output_str;
end

