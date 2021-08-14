// -----------------------------------------------------------------------------
// inkWidget Imports
// -----------------------------------------------------------------------------
//
// - Parent widget
// - Primary logic controller
// - Secondary logic controllers
//
// -----------------------------------------------------------------------------
//
// class inkWidget {
//   public func GetParentWidget() -> wref<inkWidget>
//   public func SetController(controller: ref<inkLogicController>) -> Void
//   public func AddSecondaryController(controller: ref<inkLogicController>) -> Void
// }
//

@addField(inkWidget)
native let parentWidget: wref<inkWidget>;

@addField(inkWidget)
native let logicController: ref<inkLogicController>;

@addField(inkWidget)
native let secondaryControllers: array<ref<inkLogicController>>;

@addMethod(inkWidget)
public func GetParentWidget() -> wref<inkWidget> {
	return this.parentWidget;
}

@addMethod(inkWidget)
public func SetController(controller: ref<inkLogicController>) -> Void {
	this.logicController = controller;
}

@addMethod(inkWidget)
public func AddSecondaryController(controller: ref<inkLogicController>) -> Void {
	ArrayPush(this.secondaryControllers, controller);
}
