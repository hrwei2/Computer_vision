function [output] = relu_forward(input)

output.height = input.height;
output.width = input.width;
output.channel = input.channel;
output.batch_size = input.batch_size;
% Replace the following line with your implementation.
%temp = input.data;
%temp( temp <= 0 ) = 0;
output.data = max(input.data,0);
end
