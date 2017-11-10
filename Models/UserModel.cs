using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public class UserModel
    {
        [MinLength(2)]
        [MaxLength(10)]
        public string FirstName { get; set; }

        [Required]
        public string LastName { get; set; }

        [Required(ErrorMessage = "Please supply your email address.")]
        public string EmailAddress { get; set; }

        [Range(1, 100)]
        public int Age { get; set; }
        public string Location { get; set; }

        [Required]
        public string Subscription { get; set; }

        [Required]
        public string Password { get; set; }
    }
}