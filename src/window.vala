namespace EvolveJournal
{
	public class Window : Gtk.Window
	{
		public Application root;
		public Application mother;
		public Window window;
		
		public Config config;
	
		public HeaderBar header_bar;
		
		public Gtk.Box main_box;
		public Gtk.Revealer sidebar_revealer;
		public SideBar sidebar;
		public FileBar filebar;
		public Gtk.Box centre_box;
		public Gtk.Overlay source_stack_overlay;
		public SourceStack source_stack;
		public Gtk.Revealer terminal_revealer;
		public Gtk.ScrolledWindow terminal_scrolled_window;
		public Terminal terminal;
		public Gtk.Revealer settingsbar_revealer;
		public SettingsBar settingsbar;
	
		public Window(Application mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this;
			
			this.config = new Config(this.root.consts);
			this.config.setProperty("line-numbers", "true");
			this.config.setProperty("scheme", "classic");
			this.config.setProperty("show-terminal", "false");
			this.config.setProperty("show-sidebar", "false");
			this.config.setProperty("show-settingsbar", "false");
			this.config.setProperty("show-sidebar", "false");
		
			this.set_size_request(this.root.consts.min_width, this.root.consts.min_height);
			this.set_default_size(this.root.consts.default_width, this.root.consts.default_height);
			this.destroy.connect(this.root.close);
		
			this.header_bar = new HeaderBar(this);
			//this.add(this.header_bar);
			this.set_titlebar(this.header_bar);
			//this.header_bar.set_opacity(0.3f);
			//this.header_bar.set_vexpand(false);
			
			this.main_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
			this.add(this.main_box);
			
			this.sidebar_revealer = new Gtk.Revealer();
			this.sidebar_revealer.set_transition_type(Gtk.RevealerTransitionType.SLIDE_RIGHT);
			this.main_box.add(this.sidebar_revealer);
			
			this.sidebar = new SideBar(this);
			this.sidebar_revealer.add(this.sidebar);
			
			this.filebar = new FileBar(this);
			this.main_box.add(this.filebar);
		
			this.centre_box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
			this.main_box.add(this.centre_box);
		
			this.source_stack_overlay = new Gtk.Overlay();
			this.centre_box.add(this.source_stack_overlay);
		
			this.source_stack = new SourceStack(this);
			this.source_stack_overlay.add(this.source_stack);
			
			this.terminal_revealer = new Gtk.Revealer();
			this.terminal_revealer.set_transition_type(Gtk.RevealerTransitionType.SLIDE_UP);
			this.centre_box.add(this.terminal_revealer);
			
			this.terminal_scrolled_window = new Gtk.ScrolledWindow(null, null);
			this.terminal_scrolled_window.height_request = 200;
			this.terminal_scrolled_window.set_hexpand(false);
			this.terminal_scrolled_window.set_shadow_type(Gtk.ShadowType.ETCHED_OUT);
			this.terminal_revealer.add(this.terminal_scrolled_window);
			
			this.terminal = new Terminal(this);
			this.terminal_scrolled_window.add(this.terminal);
			
			this.settingsbar_revealer = new Gtk.Revealer();
			this.settingsbar_revealer.set_transition_type(Gtk.RevealerTransitionType.SLIDE_LEFT);
			this.settingsbar_revealer.set_halign(Gtk.Align.END);
			this.source_stack_overlay.add_overlay(this.settingsbar_revealer);
			
			this.settingsbar = new SettingsBar(this);
			this.settingsbar_revealer.add(this.settingsbar);
			
			this.config.dataChanged.connect(this.dataWindowChanged);
		}
		
		public void showSideBar(bool show)
		{
			this.sidebar_revealer.set_reveal_child(show);
			
			//Used for switching the icon
			if (this.sidebar_revealer.get_child_revealed())
				this.filebar.sidebar_button.set_image(new Gtk.Image.from_icon_name("pane-hide-symbolic", Gtk.IconSize.MENU));
			else
				this.filebar.sidebar_button.set_image(new Gtk.Image.from_icon_name("pane-show-symbolic", Gtk.IconSize.MENU));
		}
		
		public void dataWindowChanged(string name, string data)
		{
			switch (name)
			{
				case ("show-terminal"):
					this.terminal_revealer.set_reveal_child(bool.parse(data));
					break;
				
				case ("show-settingsbar"):
					this.settingsbar_revealer.set_reveal_child(bool.parse(data));
					break;
				
				case ("show-sidebar"):
					this.showSideBar(bool.parse(data));
					break;
			}
		}
	}
}