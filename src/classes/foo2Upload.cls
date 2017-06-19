global class foo2Upload implements iterable<String>
{
   global Iterator<String> Iterator()
   {
      return new CustomIterable2Upload();
   }
}