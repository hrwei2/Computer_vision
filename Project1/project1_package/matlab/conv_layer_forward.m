function [output] = conv_layer_forward(input, layer, param)
% Conv layer forward
% input: struct with input data
% layer: convolution layer struct
% param: weights for the convolution layer

% output: 

h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;
k = layer.k;
pad = layer.pad;
stride = layer.stride;
num = layer.num;
% resolve output shape
h_out = (h_in + 2*pad - k) / stride + 1;
w_out = (w_in + 2*pad - k) / stride + 1;

assert(h_out == floor(h_out), 'h_out is not integer')
assert(w_out == floor(w_out), 'w_out is not integer')
input_n.height = h_in;
input_n.width = w_in;
input_n.channel = c;

%% Fill in the code
% Iterate over the each image in the batch, compute response,
% Fill in the output datastructure with data, and the shape. 
output.channel = num;
output.width = w_out;
output.height = h_out;
output.batch_size=input.batch_size;

output.data = zeros([h_out, w_out, c, batch_size]);
im = reshape(input.data,input.height, input.width, c,batch_size);
im = padarray(im,[pad pad],0,'both');
%im = col2im_conv(input.data(:,batch), input, layer, h_out, w_out);
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
            for batch = 1:batch_size
                for o_c = 1:num                           
                    output.data(x_out,y_out,o_c,batch) = dot(transpose(reshape(window(:,:,:,batch),k*k*c,1)),param.w(:,o_c)) + param.b(o_c);
                end
            end
        end
        
end
temp = output.data;
output.data = reshape(temp,w_out*h_out*output.channel,batch_size);


end

