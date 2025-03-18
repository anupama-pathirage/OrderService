import ballerina/http;

type Order readonly & record {| 
    string orderId;
    string customer;
    string item;
    int quantity;
|};

table<Order> key(orderId) orders = table [
    {orderId: "O001", customer: "Alice", item: "Laptop", quantity: 1},
    {orderId: "O002", customer: "Bob", item: "Phone", quantity: 2}
];

service / on new http:Listener(9090) {

    resource function get orders() returns Order[] {
        return orders.toArray();
    }

    resource function post orders(Order orderItem) returns Order {
        orders.add(orderItem);
        return orderItem;
    }
}
