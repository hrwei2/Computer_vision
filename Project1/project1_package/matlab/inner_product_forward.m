function [output] = inner_product_forward(input, layer, param)

k = size(input.data, 2); % batch size

% Replace the following line with your implementation.

output.width = input.width;
output.height = input.height;
output.channel = input.channel;
output.batch_size = k;
b = param.b;
batch_size = k;

for y = 1:batch_size
    %output.data(:,y) = transpose(param.w)*input.data(:,y) + b;
    output.data(:,y) = transpose(input.data(:,y))*param.w + b;
end

end
