function var_full = compute_var(sig_a, fdur_a, wdur_a)

% declare local variables
%
sig_wbuf = zeros(1, wdur_a);
num_samples = length(sig_a);
num_frames = 1+round(num_samples / fdur_a);
var_full = zeros(length(sig_a),1);

% loop over the entire signal
%
for i = 1:num_frames
    
    % generate the pointers for how we will move through the data signal.
    % the center tells us where our frame is located and the ptr and right
    % indicate the reach of our window around that frame
    %
    n_center = (i - 1) * fdur_a + (fdur_a / 2);
    n_left = n_center - (wdur_a / 2);
    n_right = n_left + wdur_a - 1;
    %ensure pointers are integers
    n_left = round(n_left);
    n_right = round(n_right);
    % when the pointers exceed the index of the input data we won't be
    % adding enough samples to fill the full window. to solve this zero
    % stuffing will occur to ensure the buffer is always full of the same
    % number of samples
    %
    if( (n_left < 0) || (n_right > num_samples) )
        sig_wbuf = zeros(1, wdur_a);
    end
    
    % transfer the data to this buffer:
    %  note that this is really expensive computationally
    %
    for j = 1:wdur_a
        index = n_left + (j - 1);
        if ((index > 0) && (index <= num_samples))
            sig_wbuf(j) = sig_a(index);
        end
    end
    
    % find variance of the signal
    % to build the value for that frame
    %
    var1 = var(sig_wbuf);
    
    % assign the var value to the output signal:
    %  note that we write fdur_a values
    %
    for j = 1:fdur_a
        index = n_center + (j - 1) - (fdur_a/2);
        if ((index > 0) && (index <= num_samples))
            var_full(index) = var1;
        end
    end
end

% exit gracefully
%
end
