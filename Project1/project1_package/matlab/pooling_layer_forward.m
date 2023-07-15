function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    % Replace the following line with your implementation.
    %need to convert data first then convert back
    %need to do this for each channel, each channel is X
    output.data = zeros([h_out, w_out, c, batch_size]);
    im = reshape(input.data,input.height, input.width, c,batch_size);
    im = padarray(im,[pad pad],0,'both');

    dif = floor(k/2);
    for x =  k/2:stride:w_in+2*pad-k/2
        
            for y =  k/2:stride:h_in+2*pad-k/2
                if k == 2
                    window = im(ceil(x):ceil(x)+dif,ceil(y):ceil(y)+dif,:,:);
                else
                    window = im(ceil(x)-dif:ceil(x)+dif,ceil(y)-dif:ceil(y)+dif,:,:);
                end
                x_out = (x-k/2)/stride + 1;
                y_out = (y-k/2)/stride + 1;
                for channel = 1:c
                    for batch = 1:batch_size
                        output.data(x_out,y_out,channel,batch) = max(window(:,:,channel,batch),[],'all');
                    end
                end
            end
    end

    
    output.data = reshape(output.data,w_out*h_out*c,batch_size);

end

