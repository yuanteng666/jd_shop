import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();


class ProductContentBus{
    String string;

    ProductContentBus(this.string);

}

class UserBus{
    String string;

    UserBus(this.string);

}