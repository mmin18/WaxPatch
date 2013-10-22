## Wax Loader
Mutated version of Wax (https://github.com/probablycorey/wax/)

Support method override and direct method call from Obj-C code, which gives you the ability to dynamically change the behavior of a running iOS application.

It has been proved stable on more than 5,000,000 devices.
### Tutorial
The patch is a zip file contains patch.lua and other lua codes. The sample code can be found at /patch folder.

The sample iOS project loads the patch from a url (which you probably want to change in AppDelegate.m) before launch.

##### The original version in obj-c:

![Original](https://raw.github.com/mmin18/Create-a-More-Flexible-App/master/WaxOriginal.png)

    @implementation MainViewController
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 10;
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
        return cell;
    }
    
    @end

##### The pacthed version with lua:

![Patched](https://raw.github.com/mmin18/Create-a-More-Flexible-App/master/WaxPatched.png)

    waxClass{"MainViewController", UITableViewController}
    
    function tableView_cellForRowAtIndexPath(self, tableView, indexPath)
    	local cell = self:ORIGtableView_cellForRowAtIndexPath(tableView, indexPath) -- The original method is retained with 'ORIG' prefix
    	cell:textLabel():setText("" .. (10 - indexPath:row()))
    	cell:detailTextLabel():setText("http://github.com/mmin18")
    	cell:textLabel():setTextColor(UIColor:redColor())
    	return cell
    end

