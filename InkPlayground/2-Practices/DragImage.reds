module InkPlayground.Practices
import InkPlayground.Workbench.Practice

public class DragImage extends Practice {
	protected let m_logo: ref<inkImage>;

	protected let m_dragStartCursor: Vector2;

	protected let m_dragStartMargin: inkMargin;

	protected let m_dragAnimDef: ref<inkAnimDef>;

	protected let m_dragAnimProxy: ref<inkAnimProxy>;

	protected cb func OnCreate() -> Void {
		let root: ref<inkCanvas> = new inkCanvas();
		root.SetName(this.GetClassName());
		root.SetAnchor(inkEAnchor.Fill);

		let logo: ref<inkImage> = new inkImage();
		logo.SetName(n"logo");
		logo.SetAtlasResource(r"base\\gameplay\\gui\\fullscreen\\main_menu\\menu_background.inkatlas");
		logo.SetTexturePart(n"cp_logo");
		logo.SetAnchor(inkEAnchor.TopLeft);
		logo.SetAnchorPoint(new Vector2(0.0, 0.0));
		logo.SetSize(new Vector2(1180.0 / 2.0, 292.0 / 2.0));
		logo.SetInteractive(true);
		logo.Reparent(root);

		this.m_logo = logo;

		this.SetRootWidget(root);
	}

	protected cb func OnInitialize() -> Void {
		let area: Vector2 = this.GetAreaSize();
		let size: Vector2 = this.m_logo.GetSize();
		this.m_logo.SetMargin(new inkMargin((area.X - size.X) / 2.0, 155.0, 0.0, 0.0));

		let scaleAnim: ref<inkAnimScale> = new inkAnimScale();
		scaleAnim.SetStartScale(new Vector2(0.9, 0.9));
		scaleAnim.SetEndScale(new Vector2(1.0, 1.0));
		scaleAnim.SetType(inkanimInterpolationType.Linear);
		scaleAnim.SetMode(inkanimInterpolationMode.EasyOut);
		scaleAnim.SetDuration(0.2);

		let alphaAnim: ref<inkAnimTransparency> = new inkAnimTransparency();
		alphaAnim.SetStartTransparency(0.4);
		alphaAnim.SetEndTransparency(1.0);
		alphaAnim.SetType(inkanimInterpolationType.Linear);
		alphaAnim.SetMode(inkanimInterpolationMode.EasyOut);
		alphaAnim.SetDuration(0.3);

		let animDef: ref<inkAnimDef> = new inkAnimDef();
		animDef.AddInterpolator(scaleAnim);
		animDef.AddInterpolator(alphaAnim);

		let animOpts: inkAnimOptions;
		animOpts.executionDelay = 0.15;

		this.m_logo.PlayAnimationWithOptions(animDef, animOpts);
		this.m_logo.RegisterToCallback(n"OnPress", this, n"OnPress");

		this.Log("[Drag Image] Logo is ready");
	}

	protected cb func OnPress(evt: ref<inkPointerEvent>) -> Bool {
		if evt.IsAction(n"mouse_left") {
			this.m_dragStartMargin = this.m_logo.GetMargin();
			this.m_dragStartCursor = evt.GetScreenSpacePosition();

			this.RegisterToGlobalInputCallback(n"OnPostOnRelative", this, n"OnGlobalMove");
			this.RegisterToGlobalInputCallback(n"OnPostOnRelease", this, n"OnGlobalRelease");

			let alphaAnim: ref<inkAnimTransparency> = new inkAnimTransparency();
			alphaAnim.SetStartTransparency(1.0);
			alphaAnim.SetEndTransparency(0.4);
			alphaAnim.SetType(inkanimInterpolationType.Linear);
			alphaAnim.SetMode(inkanimInterpolationMode.EasyInOut);
			alphaAnim.SetDuration(0.4);

			let animDef: ref<inkAnimDef> = new inkAnimDef();
			animDef.AddInterpolator(alphaAnim);

			let animOpts: inkAnimOptions;
			animOpts.loopType = inkanimLoopType.PingPong;
			animOpts.loopInfinite = true;

			this.m_dragAnimProxy = this.m_logo.PlayAnimationWithOptions(animDef, animOpts);
		};
	}

	protected cb func OnGlobalMove(evt: ref<inkPointerEvent>) -> Void {
		let cursor: Vector2 = evt.GetScreenSpacePosition();
		let margin: inkMargin = this.m_dragStartMargin;
		let size: Vector2 = this.m_logo.GetSize();
		let area: Vector2 = this.GetAreaSize();

		margin.left += (cursor.X - this.m_dragStartCursor.X) * 2.0;
		margin.left = MaxF(margin.left, 0);
		margin.left = MinF(margin.left, area.X - size.X);

		margin.top += (cursor.Y - this.m_dragStartCursor.Y) * 2.0;
		margin.top = MaxF(margin.top, 0);
		margin.top = MinF(margin.top, area.Y - size.Y);

		this.m_logo.SetMargin(margin);
	}

	protected cb func OnGlobalRelease(evt: ref<inkPointerEvent>) -> Bool {
		if evt.IsAction(n"mouse_left") {
			this.UnregisterFromGlobalInputCallback(n"OnPostOnRelative", this, n"OnGlobalMove");
			this.UnregisterFromGlobalInputCallback(n"OnPostOnRelease", this, n"OnGlobalRelease");

			let alphaAnim: ref<inkAnimTransparency> = new inkAnimTransparency();
			alphaAnim.SetStartTransparency(this.m_logo.GetOpacity());
			alphaAnim.SetEndTransparency(1.0);
			alphaAnim.SetType(inkanimInterpolationType.Linear);
			alphaAnim.SetMode(inkanimInterpolationMode.EasyInOut);
			alphaAnim.SetDuration(0.1);

			let animDef: ref<inkAnimDef> = new inkAnimDef();
			animDef.AddInterpolator(alphaAnim);

			this.m_dragAnimProxy.Stop();
			this.m_dragAnimProxy = this.m_logo.PlayAnimation(animDef);
		};
	}
}
