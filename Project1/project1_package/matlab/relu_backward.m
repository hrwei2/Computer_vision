function [input_od] = relu_backward(output, input, layer)

% Replace the following line with your implementation.
der_relu = input.data;
der_relu( der_relu <= 0 ) = 0;
der_relu( der_relu > 0 ) = 1;
input_od = output.diff.*der_relu;
end
