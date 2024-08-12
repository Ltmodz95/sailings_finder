module GraphUtils
  def dfs_search(nodes, path, source = nil)
    path.append source[:sailing_code] if source
    save_sailing_line path if source && source[:to].value == @destination

    path.pop if nodes.empty?

    nodes.each do |node|
      dfs_search(node[:to].adj_list, path, node)
    end
  end

  def save_sailing_line(path)
    @shipments << path[0..]
  end
end
