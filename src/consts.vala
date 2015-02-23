namespace Vulcan
{
	public class Consts : Object
	{
		public string name = "Vulcan";
		public string comment = "A Gtk app to edit your text files";
		public int[] version = {0, 1, 0};
		public string version_string;
	
		public int min_width = 600;
		public int min_height = 400;
	
		public int default_width = 800;
		public int default_height = 600;
		
		public Application application;
		
		public Consts(Application application)
		{
			this.application = application;
			
			this.version_string = @"$(this.version[0]).$(this.version[1])";
		}
	
		public void output(string message, string type = "debug")
		{
			if ((bool.parse(this.application.config.getProperty("debug")) && type == "debug") || type != "debug")
				stdout.printf("[" + type.up() + "] " + message + "\n");
		}
	}
}
